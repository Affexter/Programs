## Grade into grade letter converter

AccRange = {
    'F': list(range(0, 20)),
    'D': list(range(20, 40)),
    'C': list(range(40, 70)),
    'B': list(range(70, 80)),
    'A': list(range(80, 100))
}
Grades = [0, 10, 40, 40, 10]

class StudentBody:
    def __init__(self, name, grades):
        self.name = name
        self.grades = grades

    def get_grades(self):
        grade_list = []
        for val in self.grades:
            for grade_letter, range_list in AccRange.items():
                if val in range_list:
                    grade_list.append(grade_letter)
                    break
        return grade_list
                    

student = StudentBody('Jessica', Grades)

print(f'Student Name = {student.name}, Grades = {student.get_grades()}')