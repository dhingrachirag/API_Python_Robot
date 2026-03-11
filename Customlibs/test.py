import requests

url = "https://api.securemobi.net/v2/oauth2/token"

payload = "grant_type=client_credentials"
headers = {
    "accept": "application/json",
    "content-type": "application/x-www-form-urlencoded",
    "authorization": "Basic NzhhNzU1YzktNTlkMi0xMWVkLWE5NzEtNjkyY2VjYmVkZTQ4OmVOUE1xR2FjVlRxWTJFV1UvVFJKekRmR2VmRFk1NWpGTkI0a2RkSStRQUU9"
}

response = requests.post(url, data=payload, headers=headers)

print(response.text)