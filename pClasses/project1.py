AccRange = {
    'F': list(range(0, 20)),
    'D': list(range(20, 40)),
    'C': list(range(40, 70)),
    'B': list(range(70, 80)),
    'A': list(range(80, 100))
}
Grades = [94, 87, 66, 20, 50]

class StudentBody:
    def __init__(self, name, grades):
        self.name = name
        self.grades = grades

    def get_grades(self):
        for val in self.grades:
            for num, range_list in AccRange.items():
                if val in range_list:
                    print(num, range_list)

student = StudentBody('Jessica', Grades)
student.get_grades()