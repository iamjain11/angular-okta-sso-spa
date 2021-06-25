# Okta Angular SPA Application

User authentication is based on Okta SSO, application will redirect the user to okta login, once user provide valid credentials
user will be redirected to the app.

## Prerequisites

Before running this application, you will need the following:

* An Okta Developer Account, you can sign up for one at https://developer.okta.com/signup/.
* An Okta Application, configured for Singe-Page App (SPA) mode. This is done from the Okta Developer Console and you can find instructions. 
  Application --> application --> Create App Integration --> OIDC - OpenID Connect --> Single-Page Application --> Next
  provide any name and save
When following the wizard, use the default properties.  They are are designed to work with this applications.


## Running This Example

To run this application, you first need to clone this repo and then enter into this directory:

Note : angular cli 10 and nodejs 12+ is required 

```bash
git clone https://github.com/iamjain11/angular-okta-sso-spa.git
cd angular-okta-sso-spa
```

Then install dependencies:

```bash
npm install
```

Now you need to gather the following information from the Okta Developer Console:

- **Client Id** - The client ID of the SPA application that you created earlier. This can be found on the "General" tab of an application, or the list of applications.  This identifies the application that tokens will be minted for.
- **Issuer** - This is the URL of the authorization server that will perform authentication.  All Developer Accounts have a "default" authorization server.  The issuer is a combination of your Org URL (found in the upper right of the console home page) and `/oauth2/default`. For example, `https://dev-1234.oktapreview.com/oauth2/default`.

These values must exist as environment variables. They can be exported in the shell, or saved in a file named `app-config.env`, at the root of this repository. (This is the parent directory, relative to this README) See [dotenv](https://www.npmjs.com/package/dotenv) for more details on this file format.

```ini
ISSUER=https://yourOktaDomain.com/oauth2/default
CLIENT_ID=123xxxxx123
```

Now start the app server:

```
npm start
```

Now navigate to http://localhost:8080 in your browser.

If you see a home page that prompts you to login, then things are working!  Clicking the **Log in** button will redirect you to the Okta hosted sign-in page.

You can login with the same account that you created when signing up for your Developer Org, or you can use a known username and password from your Okta Directory.

**Note:** If you are currently using your Developer Console, you already have a Single Sign-On (SSO) session for your Org.  You will be automatically logged into your application as the same user that is using the Developer Console.  You may want to use an incognito tab to test the flow from a blank slate.


# using docker-compose 

    $ docker-compose -f docker-compose.yml up --build

# using docker compose detached mode

     $ docker-compose -f docker-compose.yml up -d --build
     $ docker logs angular-okta-sso-service -f


# EC2 Setup 

    1. login to aws console --> ec2 service --> instances
        i) create a ec2 instance --> ubuntu/amazon linux, download keypair pem file
        ii) chmod 400 your-keypair.pem
        iii) ssh -i /path/your-keypair.pem ubuntu@public_dns_name 
        iv) install docker https://github.com/iamjain11/aws-instance-setup-scripts/blob/master/aws_ubuntu_docker_ce_setup.sh or https://docs.aws.amazon.com/AmazonECS/latest/developerguide/docker-basics.html
        iv) git clone https://github.com/iamjain11/angular-okta-sso-spa.git
        v) cd angular-okta-sso-spa
        vi) docker-compose -f docker-compose.yml up -d --build

        Note 1 : you can use public dns name or ip, username depends on which linux image you are selecting for ec2
        Example for ubuntu image username is ubuntu and for amazon linux ec2-user
        git is available in ubuntu for other images use 
          $ sudo apt install git -y
          $ sudo yum install git -y
          $ sudo apk install git -y
        use the above command depends on image selection, ubuntu/amazon linux/centos etc.

        Note 2: without docker 
            i) git clone https://github.com/iamjain11/angular-okta-sso-spa.git
            ii) cd angular-okta-sso-spa
            iii) npm install && npm run build
            iv) sudo apt install nginx -y
            v) rm -rf /usr/share/nginx/html/* && rm -rf /etc/nginx/nginx.conf
            vi) cp ./dist/angular-okta-spa-sso /usr/share/nginx/html
            vii) cp ./nginx.conf /etc/nginx/nginx.conf
            vii) sudo systemctl restart nginx


        Note 3: to use ssl

          i) update nginx.conf with 443 port and provide cert details and restart nginx or setup a route 53 with ssl with ELB
        



