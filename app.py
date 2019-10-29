from flask import Flask, render_template
 
app = Flask(__name__)
 
@app.route('/')
def health_check():
    return "healthy"
 
if __name__ == '__main__':
    app.run(debug=True, host='0.0.0.0')