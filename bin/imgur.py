#!/usr/bin/python3
import requests
import sys
import os


apikey = '0f1e7810502fded'
apiurl = 'https://api.imgur.com/3/upload'
deleteurl = 'https://imgur.com/delete/{}'


def upload(f: str) -> 'img url' 'delete url':
    f = os.path.expanduser(f)
    try:
        with open(f, 'rb') as f:
            headers = {'Authorization': 'Client-ID {}'.format(apikey)}
            data = {'image': f.read()}
            req = requests.post(apiurl, headers=headers, data=data)
            if req.status_code == 415:
                return 'Invalid File', 'Invalid File'
            json = req.json()
            if json['success']:
                return (json['data']['link'],
                        deleteurl.format(json['data']['deletehash']))
    except Exception as e:
        print('Error: ' + e)


def main():
    if len(sys.argv) == 1:
        print('Usage: {} <image>'.format(sys.argv[0].split('/')[-1]))
        sys.exit(1)
    url, delete = upload(sys.argv[1])
    print(url)
    print(delete, file=sys.stderr)


if __name__ == '__main__':
    main()
