import re
import easyocr
import numpy as np

class EasyOCRCustom():
    def __init__(self):
        self.reader = easyocr.Reader(['en'])
    
    def getTotalFromImage(self, img_path: str):
        try:
            result = np.array(self.reader.readtext(img_path))
            total = result[np.where(result[:,1] == "TOTAL")[0][0]+1, 1]
            total = int(re.sub("[^\d\.]", "", total))
            return {
                "success" : True,
                "data" : total
            }
        except:
            return {
                "success" : False,
                "message" : "Failed! Can't Recognize this Image!"
            }