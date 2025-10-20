import os

if os.getenv("NEW_RELIC_LICENSE_KEY"):
    import newrelic.agent
    newrelic.agent.initialize()

from flask import Flask

app = Flask(__name__)

@app.route('/')
def hello():
    return {
        "message": "Hello from DevOps in Porto Alegre!",
        "status": "healthy",
        "region": "POA, RS"
    }

@app.route('/health')
def health():
    return {"status": "ok"}, 200

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=int(os.getenv("PORT", 5000)))