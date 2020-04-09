import jwt
import datetime
import sys
import os

secret_key = os.getenv('AUTH_SECRET_KEY')
print('using secret key', secret_key)

payload = {
    "sub": "1234567890",
    "admin": False,
    "iat": datetime.datetime.utcnow(),
    "exp": datetime.datetime.utcnow() + datetime.timedelta(seconds=2 * 365 * 24 * 3600),
    "https://budzonnerie.ch/jwt/claims": {
        "x-hasura-allowed-roles": [
            "consumer"
        ],
        "x-hasura-default-role": "consumer",
        "x-hasura-user-id": sys.argv[1],
        "x-hasura-org-id": "1"
    }
}
encoded_jwt = jwt.encode(payload, secret_key, algorithm='RS256')

print(encoded_jwt.decode(encoding='utf-8'))
