from flask import Flask, render_template
app = Flask(__name__)

@app.route("/")
def index():
    return render_template('lesson.html', lesson_name="lesson-one")

@app.route("/lesson/<lesson_name>")
def lesson(lesson_name):
    return render_template('lesson.html', lesson_name=lesson_name)

if __name__ == "__main__":
    app.run(host="0.0.0.0", debug=True)
