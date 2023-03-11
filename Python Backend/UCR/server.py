import lambda_function

from flask import Flask

app = Flask(__name__)

@app.route('/run_script')
def run_script():
    # Call the python script here and return the result
    return lambda_function.lambda_handler("", "")

if __name__ == '__main__':
    app.run()