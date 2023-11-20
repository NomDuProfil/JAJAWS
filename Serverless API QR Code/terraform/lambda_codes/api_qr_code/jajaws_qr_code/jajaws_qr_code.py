import json, segno, base64
from io import BytesIO

def build_response(code, message):
    return {
        'statusCode': code,
        'body': message,
        'headers': {
            'Content-Type': 'application/json',
            'Access-Control-Allow-Origin': '*'
        }
    }

def lambda_handler(event, context):
    if event['httpMethod'] == 'POST':
        json_event = json.loads(event['body'])
        if len(json_event["text_to_convert"]) > 100:
            return build_response(400, 'Too long!')
        else:
            qrcode = segno.make(json_event["text_to_convert"], version=5)
            image_stream = BytesIO()
            qrcode.save(image_stream, scale=10, kind='png')
            image_stream.seek(0)
            base64_encoded = base64.b64encode(image_stream.read()).decode('utf-8')
            return build_response(200, base64_encoded)
    return build_response(200, 'Hello you')