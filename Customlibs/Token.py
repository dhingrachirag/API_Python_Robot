class AsavieAuth(AuthBase):
    """Attaches Authentication to the given Request object."""

    def __init__(self, username, password) -> None:
        self.basic_auth = basic_auth = base64.b64encode(f"{username}:{password}".encode('ASCII')).decode('ASCII')
        self.last_auth = None
        self.token_expires = 0

    def __call__(self, r) -> str:
        # check first to see if we already have a bearer token and that is has not expired
        epoch_now = datetime.now(timezone.utc).timestamp()
        if self.last_auth is None or (epoch_now + 60) >= self.token_expires:  # Add 60 seconds margin
            # Get a new bearer token
            headers = {"Accept": "application/json", "Content-Type": "application/x-www-form-urlencoded",
                       "Authorization": f"Basic {self.basic_auth}"}
            payload = {"grant_type": "client_credentials"}
            resp = requests.post(f"{URL}/oauth2/token", data=payload, headers=headers)
            if resp.status_code != 200:
                raise Exception(f"Authentication error getting bearer token: {resp.status_code}:{resp.reason}")
            self.last_auth = resp.json()
            self.token_expires = epoch_now + self.last_auth['expires_in']
        r.headers['Authorization'] = f'Bearer {self.last_auth["access_token"]}'
        return r


# Bind the token to our http Session
http.auth = AsavieAuth(API_KEY, API_SECRET)