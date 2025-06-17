from flask import Flask, render_template, request, redirect, url_for, session
import sys
import os
from scripts.run_serotyping import run_serotyping
from scripts.run_mlst import run_mlst

# Add parent directory to path
sys.path.append(os.path.abspath(os.path.join(os.path.dirname(__file__), '..')))

app = Flask(__name__)
app.secret_key = os.environ.get('SECRET_KEY', 'fallback-dev-key') # Required for using sessions
app.config['UPLOAD_FOLDER'] = 'app/uploads'
os.makedirs(app.config['UPLOAD_FOLDER'], exist_ok=True)  # checks if the folder exists


@app.route('/', methods=['GET', 'POST'])
def index():
    if request.method == 'POST':
        if 'file' not in request.files:
            return redirect(request.url)
        file = request.files['file']
        if file.filename == '':
            return redirect(request.url)
        
        filepath = os.path.join(app.config['UPLOAD_FOLDER'], file.filename)
        file.save(filepath)

        try:
            serotyping_result = run_serotyping(filepath)
            mlst_result = run_mlst(filepath)
            mlst_result["sequence_type"] = int(mlst_result["sequence_type"])

            print("==> Serotyping result:", serotyping_result)
            print("==> MLST result:", mlst_result)

            session['filename'] = file.filename
            session['serotyping_result'] = serotyping_result
            session['mlst_result'] = mlst_result

            return redirect(url_for('results'))

        except Exception as e:
            print("==> ERROR processing file:", e)
            return "Internal server error", 500

    # Clear session if just reloading home
    session.clear()
    return render_template('index.html')


@app.route('/results')
def results():
    return render_template('index.html',
                           filename=session.get('filename'),
                           serotyping_result=session.get('serotyping_result'),
                           mlst_result=session.get('mlst_result'))


if __name__ == '__main__':
    app.run(debug=True)