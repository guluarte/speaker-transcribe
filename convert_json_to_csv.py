import csv
import sys
import json

    

def write_csv(json_file, output, prompter):
    f = open(json_file)
  
    data = json.load(f)
    
    csv_file = open(f"{output}-prompter-{prompter}.csv", 'w+')
    text_file = open(f"{output}-human-{prompter}.txt", "w+")
    writer = csv.writer(csv_file)
    
    writer.writerow(["prompt", "completion"])
    
    prompt = " Hi! "
    completion = ""
  
    for seg in data['text']:
        print(seg)
        text = seg['text']
        if seg['speaker'] == prompter:
            prompt = f'{prompt}{text}'
        elif prompt != "":
            completion = f'{completion}{text}'
        
        if prompt != "" and completion != "":
            writer.writerow([f"USER: {prompt}\n", f"{completion} ###\n"])
            text_file.write(f"USER:{prompt}\n")
            text_file.write(f"AI:{completion}\n")
            prompt = ""
            completion = ""
            
    # Closing file
    f.close()
    text_file.close()
    csv_file.close()
        
def main() -> int:
    """Echo the input arguments to standard output"""
    print("use: python convert_json_to_csv.py \"./test.json\" \"./output.csv\"")
    json_file = sys.argv[1]
    output = sys.argv[2] if len(sys.argv) > 2 else "./output.csv"
    print("Json file:[{}]".format(json_file))
    print("Output file:[{}]".format(output))
    write_csv(json_file, output, "A")
    write_csv(json_file, output, "B")
    return 0


if __name__ == '__main__':
    sys.exit(main())  #
