"""Validate the script map name match the temp context file."""
from argparse import ArgumentParser
from pathlib import Path
import xml.etree.ElementTree as ET


def main():
    parser = ArgumentParser(description="Validate script map names")
    parser.add_argument("-f", "--script-folder", required=True)
    parser.add_argument("-x", "--context-xml", required=True)
    args = parser.parse_args()

    root_info = ET.parse(args.context_xml).getroot()
    for info in root_info.iter('Script'):
        filename = info.attrib['File']
        map1 = info.attrib["MapName"]
        # context1 = info.attrib["Context"]

        script_path = Path(args.script_folder, filename + ".xml")
        with script_path.open() as script:
            root_script = ET.parse(script).getroot().find("Header")
            map2 = root_script.find("MapName").text
            # context2 = root_script.find("Context").text
            if map2 and map1 != map2:
                print(f"Different name for {filename}. temp_context says '{map1}' but script says '{map2}'")
            #if context1 != context2:
            #    print(f"Different context for {filename}: {context2} -> {context1}")



if __name__ == "__main__":
    main()
