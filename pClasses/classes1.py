class CTemplate():
    def __init__(self, Name, Hair_Color, Age):
        Name = Name
        Hair_Color = Hair_Color
        Age = Age


create = CTemplate('john', 'green', 90)

if create.Name and create.Hair_Color and create.Age:
    print(f'Hello {create.Name}, you are {create.Age}! Your hair color is {create.Hair_Color}')