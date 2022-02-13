# ShareCab : An organisation carpool app ! 

## Problem Statement :-

Often in college we have noticed the messages like " who is going to airport on this day and this time from campus".  This is not only limited to college but also in large organisation where people have to depend on traditional WhatsApp messages and phone calls which makes the entire benifit of going together becomes a burden ! 

## Our Solution :- 

We decided to help people to carpool by creating a mobile application which serves as a one stop check for everyone in the same organisation to carpool! The app mainly consist of a login screen which serves as a login as well as registration screen. The validity of the email is verified via OTP ([attribution](https://pub.dev/packages/email_auth)). This is followed by a simplistic UI where a user can add their booking as well as check how many might be already travelling during that slot.  Once we have booked we can regularly come back to the app and check if someone else have also booked a slot to travel together. You can get the details of the user (Name, Email ID. This can be extended to more fields as per the organisation's preference) and can connect to travel together ! There is also a delete option added which can help you remove yourself from the list of travellers on a particular slot. For now we create this model for a uni-directional travel (i.e From College to Airport or vice versa ) but this can be easilty scaled up to add Location based support also.  

## Technologies Utilized :-

The following set of technologies have been used for this project:

**1) Firebase** (for cloud storage/database)

**2) Flutter** (UI and platform)

**3) Dart** (Interfacing the UI and database)

## Screenshots  :-
<p float ="left">
<img src="https://github.com/ishaanj0412/Carpool/blob/a34bccce77ff397a046ceb1f21234082e04688fd/Readme_pics/1.jpeg" alt="Login" width="300" /> 
<img src="https://github.com/ishaanj0412/Carpool/blob/a34bccce77ff397a046ceb1f21234082e04688fd/Readme_pics/2.jpeg" alt="OTP verification" width="300" /> 
<img src="https://github.com/ishaanj0412/Carpool/blob/a34bccce77ff397a046ceb1f21234082e04688fd/Readme_pics/3.jpeg" alt="HomeScreen" width="300" />
</p>
<p float ="left">
<img src="https://github.com/ishaanj0412/Carpool/blob/a34bccce77ff397a046ceb1f21234082e04688fd/Readme_pics/4.jpeg" alt="4" width="300" />
<img src="https://github.com/ishaanj0412/Carpool/blob/a34bccce77ff397a046ceb1f21234082e04688fd/Readme_pics/5.jpeg" alt="5" width="300" />
<img src="https://github.com/ishaanj0412/Carpool/blob/a34bccce77ff397a046ceb1f21234082e04688fd/Readme_pics/6.jpeg" alt="6" width="300" /> 
</p>


# How to run the project

- ### For Testing and use :-

  - Run the .apk file from this [link]() 

  - Install the following .apk on your device. Please note you may need to allow external app installs on your phone 

    - On non-Samsung devices:

      - Go to your phone’s **Settings**.

      - Go to **Security & privacy** > **More settings**.

      - Tap on **Install apps from external sources**.

      - Select the browser (e.g., Chrome or Firefox) you want to download the APK files from.
        [<img src="https://sp-ao.shortpixel.ai/client/to_webp,q_lossy,ret_img,w_1340,h_602/https://s23429.pcdn.co/wp-content/uploads/2016/08/andriod-install-unknown-apps.png" alt="Select the browser you want to download the APK from. " style="zoom:50%;" />](https://s23429.pcdn.co/wp-content/uploads/2016/08/andriod-install-unknown-apps.png)

      - Toggle **Allow app installs** on.

        On non-Samsung devices:

      1. Go to your phone’s **Settings**.
      2. Go to **Biometrics and security** > **Install unknown apps**.
      3. Select the browser (e.g., Chrome or Firefox) you want to download the APK files from.
      4. Toggle **Allow app installs** on.

#### 			NOTE: Please ensure you have Android 9.0 or greater. 

- ### For Developement :

  -  Setup [Flutter environment](https://docs.flutter.dev/get-started/install) and [Android Virtual Device Manager (AVD Manager)](https://medium.com/michael-wallace/how-to-install-android-sdk-and-setup-avd-emulator-without-android-studio-aeb55c014264)

  - Clone this repository 

  - Open the main.dart file from lib folder

  - You may need to run `$ dart pub get [options]` to load all the dependencies to run the code 

    #### NOTE : AVD version used to develop was 31.0 (Tested on pixel 4, 5 AVD)



### NOTE: The OTP_auth service is hosted on a test-server which allows only 30 OTP request for a single day. Also all time inputs are considered to be in 24hr format 

# Contributors

- Ishan Jalan - https://www.linkedin.com/in/ishaan-jalan-550a28213/
- Karanjit Saha - https://www.linkedin.com/in/karanjit-saha-65a02122b/
- Monjoy Narayan Choudhury - https://www.linkedin.com/in/monjoy-narayan-choudhury-a424b3200/
- Rudransh Dixit - https://www.linkedin.com/in/rudransh-dixit-a785a61ba/



# Github Repo link

https://github.com/ishaanj0412/Carpool





