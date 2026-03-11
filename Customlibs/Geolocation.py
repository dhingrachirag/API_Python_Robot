import zipfile, io
from requests_pkcs12 import post

def  download_tracelogs(
        url_global : str, pkcs12_filename_roamer: str, pkcs12_password_roamer: str, destination_path_roamer: str, id_roam: str
):
    url = url_global
    pkcs12_filename = pkcs12_filename_roamer
    pkcs12_password = pkcs12_password_roamer
    testcase = str(id_roam)
    response = post(url, data=testcase, headers={'Content-Type': 'application/json'}, verify=True,
                    pkcs12_filename=pkcs12_filename, pkcs12_password=pkcs12_password)
    z = zipfile.ZipFile(io.BytesIO(response.content))
    z.extractall(destination_path_roamer)