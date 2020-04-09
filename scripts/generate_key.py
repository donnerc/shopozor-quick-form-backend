from random import randint

def get_random_char():
    code = randint(65, 120)
    while code in range(91, 97):
        code = randint(65, 120)
    return chr(code)

random_key = ''.join([get_random_char() for _ in range(64)])