pgrades = {
    0: range(0, 30),
    1: range(30, 50),
    2: range(50, 80),
    3: range(80, 100)
}
class studentBody():
    def Grades(self, name, grade):
        self.name = name
        self.grade = grade
student = studentBody()
print(student.name('jannice', 0))
print(range(4, 8))