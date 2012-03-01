from flask import Flask, render_template
app = Flask(__name__)

@app.route("/")
def index():
    return render_template('front-page.html', lesson_name="basic-workflow")

@app.route("/lesson/<lesson_name>")
def lesson(lesson_name):
    return render_template('lesson.html', lesson_name=lesson_name)

if __name__ == "__main__":
    app.debug = True
    if app.debug:
        from flaskext.clevercss import clevercss
        clevercss(app)
    app.run(host="0.0.0.0")
