import tinify
import sys
from pathlib import Path

def process_image(image_file: str):
    key = None
    try:
        with open('key.txt', 'r', encoding='utf-8-sig') as file:
            key = file.read().strip().replace(' ', '')
    except FileNotFoundError:
        return print('API Key file not found!')
    
    if key is None:
        return print('No API Key found!')
    
    try:
        tinify.key = key

        image_path = Path(image_file)
        original_filename = Path(image_path).stem

        source = tinify.from_file(image_path)
        converted = source.convert(type=['image/jpeg'])
        converted.to_file(path=f'{original_filename}.jpeg')
        tinify.key = None
    
    except Exception as e:
        return print(e)
    

if __name__ == '__main__':
    args = sys.argv[1:]

    if not ('--f' in args):
        raise AttributeError
    
    image_file = args[args.index('--f') + 1]

    print('Wait For Image to Process...')
    process_image(image_file=image_file)
    print('Completed!')

