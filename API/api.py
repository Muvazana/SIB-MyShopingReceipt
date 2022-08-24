from flask import Flask, json, request, jsonify
import os
import urllib.request
from werkzeug.utils import secure_filename
from easyocr_custom import EasyOCRCustom
 
app = Flask(__name__)
 
# app.secret_key = "caircocoders-ednalan"
 
UPLOAD_FOLDER = 'images'
app.config['UPLOAD_FOLDER'] = UPLOAD_FOLDER
app.config['MAX_CONTENT_LENGTH'] = 16 * 1024 * 1024
 
ALLOWED_EXTENSIONS = set(['pdf', 'png', 'jpg', 'jpeg'])
 
def allowed_file(filename):
    return '.' in filename and filename.rsplit('.', 1)[1].lower() in ALLOWED_EXTENSIONS
    
@app.route('/')
def main():
    return 'Homepage'
    
@app.route('/getdummy', methods=['GET'])
def get_dummy():
    messages = {
        'success'   : True,
        'message'   : "KETERIMA",
        'data'      : "ADA"
    }
    
    resp = jsonify(messages)
    resp.status_code = 201
    return resp


@app.route('/upload', methods=['POST'])
def upload_file():
    messages = {
        'success'   : False,
        'message'   : None,
        'data'      : None
    }

    # check if the post request has the file part
    if 'files[]' not in request.files:
        messages['message'] = 'No file part in the request'
        resp = jsonify(messages)
        resp.status_code = 400
        return resp
 
    files = request.files.getlist('files[]')

    file_path = None
     
    for file in files:      
        if file and allowed_file(file.filename):
            filename = secure_filename(file.filename)
            file_path = os.path.join(app.config['UPLOAD_FOLDER'], filename)
            file.save(file_path)
            messages['success'] = True
        else:
            messages['message'] = 'File type is not allowed'
            # errors['message'] = f'{file.filename} File type is not allowed'
    
    # if success and errors:
    #     errors['message'] = 'File(s) successfully uploaded'
    #     resp = jsonify(errors)
    #     resp.status_code = 500
    #     return resp
        
    if messages['success'] and filename != None:
        messages = EasyOCRCustom().getTotalFromImage(file_path)
        if os.path.exists(file_path):
            os.remove(file_path)


    if messages['success']:
        messages['message'] = 'Files successfully uploaded'
        resp = jsonify(messages)
        resp.status_code = 201
        return resp
    else:
        resp = jsonify(messages)
        resp.status_code = 500
        return resp
 
if __name__ == '__main__':
    # app.run(debug=True)
    print("Running!")
    app.run(host='192.168.1.6', port=5000, debug=True, threaded=False)
    
