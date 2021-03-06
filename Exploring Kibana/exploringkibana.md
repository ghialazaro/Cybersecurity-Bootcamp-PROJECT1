# Exploring Kibana
1.  To explore Kibana, you can load a sample data set. In the Kibana landing page, click on Load a data set and a Kibana dashboard under Add sample data, as shown below:
![image](https://user-images.githubusercontent.com/84385348/119345517-5502b580-bcdc-11eb-8fdf-f4f6a66d386a.png)
   
2.  In the Add Data to Kibana, select Dashboard in View data dropdown in the Sample web logs, as shown below:
![Image](https://github.com/ghialazaro/Week13-Homework-PROJECT/blob/ccaafeda0d7b3be4f0c56f583eb2e03620e62712/Exploring%20Kibana/Images/Add%20Sample%20web%20log.png)

3.  Kibana dashboard with sample logs will look like this:

![image](https://user-images.githubusercontent.com/84385348/119345651-84192700-bcdc-11eb-9526-9e610b4ba2e7.png)


4.  You can specify the duration (e.g. last 15 minutes, last 7 days, et al) by clicking on the drop down beside the Show Date in the upper righ hand corner, as shown below:

![image](https://user-images.githubusercontent.com/84385348/119347088-5f25b380-bcde-11eb-9e5e-eb835f980f34.png)


5.  You can also specify the date and time by clicking on Show Date and select Absolute, as shown below:

![image](https://user-images.githubusercontent.com/84385348/119346718-ede60080-bcdd-11eb-9c89-01c6413f02a9.png)


6.  You can also filter by country and OS used, as shown below:

![image](https://user-images.githubusercontent.com/84385348/119346909-238ae980-bcde-11eb-845f-360602cc2a02.png)


## Here are some examples:

1.  In the last 7 days, there were 248 visitors located in India:

![image](https://user-images.githubusercontent.com/84385348/119347420-d9563800-bcde-11eb-863d-e6523a2944ce.png)

2.  In the last 24 hours, there were 12 visitors from China using Mac OSX.

![image](https://user-images.githubusercontent.com/84385348/119347503-f5f27000-bcde-11eb-81cc-5ad6e1880fb3.png)


3.  The dashboard also tells you the % of users that received specific errors by looking at the Response Codes Over Time + Annotations section.   For example, in the last 2 days, there were 0% users that received 404 errors and 9.091% received 503 errors.

![image](https://user-images.githubusercontent.com/84385348/119348059-b8421700-bcdf-11eb-99c2-e9c4d9142f77.png)


4.  You can also scroll down to Total Requests and Bytes section, and hover your mouse to each country to see the number of web log counts for each country.   For example, in the last 7 days, China produced the majority of the traffic on the website.

![image](https://user-images.githubusercontent.com/84385348/119347700-3b16a200-bcdf-11eb-9702-d1889a5e57a8.png)

5. You can look at the Heatmap to determine which time of day had the highest amount of activity, as shown below:

![image](https://user-images.githubusercontent.com/84385348/119349338-68644f80-bce1-11eb-9506-a89c7187286f.png)


6.  You can also see the types of files being downloaded by looking at the Host, Visits and Bytes Table.   For example, the types of downloaded files in the last 7 days are:
    - gz:  file type of gz extension are compressed archives that are created by the standard GNU zip (gzip) compression algorithm
    - css:  file type of css extension is a cascading style sheet (CSS) file used to format the contents of a webpage
    - deb:  file type of deb extension is the software package format for the Linux distribution Debian and its derivatives
    - zip:  file type of zip extension is an archive file format that supports lossless data compression

![image](https://user-images.githubusercontent.com/84385348/119348418-2dade780-bce0-11eb-8a2e-702bef266f4d.png)

    
7.  In the Unique Visitors vs. Average Bytes section, you can see the number of visitors vs Average Bytes in a 3 hour duration.  For example, the time frame in the last 7 days with the most amount of bytes was on 21 May 2021 from 06:00-09:00, as shown below:

![image](https://user-images.githubusercontent.com/84385348/119348573-66e65780-bce0-11eb-8e2f-a4deb40b5853.png)

You can click on the part of the graph that you want to analyse, as shown below:

![image](https://user-images.githubusercontent.com/84385348/119348995-ef64f800-bce0-11eb-80e1-5dc48abca3f5.png)


   - Based on the above, this activity is quite unusual, as there were less visitors but the average bytes is quite high compared to other days.

   - The time stamp with the most average bytes was 07:55 on 21 May 2021.   
    
   - The types of file being downloaded css, gz and rpm.
    
   - The https response code encountered is 200.
    
   - The countries these activities originated were China, India, Indonesia and Nigeria, as shown below:

![image](https://user-images.githubusercontent.com/84385348/119349135-23401d80-bce1-11eb-87f3-ae5e28a4c11a.png)

## Kibana Discover:
   
1.  You can switch to Kibana Discover by selecting Discover in the left hand pane of the dashboard, as shown below:

![image](https://user-images.githubusercontent.com/84385348/119350277-7d8dae00-bce2-11eb-8fda-e6b5c02a4a05.png)


2.  In the Discover page, the filter is set to filebeat by default.  Change the value of the filter to kibana_sample_data_logs, as shown below:

![image](https://user-images.githubusercontent.com/84385348/119350349-9007e780-bce2-11eb-8ee8-31a6374b028d.png)


3.  You can expand each activity to see the details, as below:

![image](https://user-images.githubusercontent.com/84385348/119350411-a3b34e00-bce2-11eb-9cc8-cad2c85db439.png)


   For example, the activity @timestamp	May 21, 2021 @ 07:25:00.241

   - The source IP address of this activity is 74.184.0.64
   - The geo coordinates of this activity are "lat": 39.07797222, "lon": -77.5575
   - The OS of the source machine was ios.
   - The full URL that was accessed was:https://artifacts.elastic.co/downloads/beats/metricbeat/metricbeat-6.3.2-i686.rpm
   - And the website the visitor's traffic originated from was:  http://facebook.com/success/william-frederick-fisher

 ## Conclusion:
It seems that the user is downloading an rpm file from artifacts.elastic.co/downloads/beats/metricbeats.  A metricbeat rpm file is generally not a malicious file.  It might      be that the user is trying to install metricbeat, hence the user is downloading the installation file from artifacts.elastic.co website.  Although there is nothing suspicious about this activity, but what is concerning is the referral link from a Facebook of a person named William Frederick Fisher.  IT is not within the complian guidelines of posting package update links on Facebook.   It is suggested to further investigate into this activity and monitor for similar activities.








    
    
