from flask import Flask

# Create a Flask application instance
app = Flask(__name__)

@app.route('/')
def hello():
    return "Hello from the Dockerized Python Web Server!"

if __name__ == '__main__':
    # '0.0.0.0' makes the server externally accessible within the container
    app.run(host='0.0.0.0', port=5000)
