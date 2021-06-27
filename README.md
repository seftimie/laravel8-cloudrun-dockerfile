# Running Laravel 8 in Cloud Run (via Dockerfile)
**consideration**: I'm not an expert, but if you can improve this setup or recommand a better one ... feel free.

In Google Cloud Platform, choose a project and then open **Cloud Shell** and run:

##### Enable cloud run and cloud build apis		

```
gcloud services enable run.googleapis.com
gcloud service enable cloudbuild.googleapis.com
```

##### Clone this repo (it contains a fresh new laravel8 app. I've only add a new route in web.php, the Dockerfile and the folder "Docker")
```
git clone https://github.com/seftimie/laravel8-cloudrun-dockerfile.git 
```
	
##### Get into the folder (hit "Open Editor" and take a look at Dockerfile and "Docker" folder)
```
cd laravel8-cloudrun-dockerfile/
```

##### Build the image (back, on cloud shell)
```
gcloud builds submit --tag gcr.io/$GOOGLE_CLOUD_PROJECT/laravel ()
```

##### Deploy the app in cloud run
```
gcloud run deploy laravel --image gcr.io/$GOOGLE_CLOUD_PROJECT/laravel --allow-unauthenticated --platform=managed --region=europe-west1
```

##### Test your app in Cloud Run 
```
https://laravel-**************.run.app/
https://laravel-**************.run.app/demo (should return a json response)
```


