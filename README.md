# CNN_image_classification
The project aims to develop a computer vision system that automates the identification of different irrigation treatments in cotton fields using aerial images. This is crucial for optimizing water usage and improving the efficiency of irrigation practices, thereby enhancing crop yield and sustainability in regions facing water scarcity.

Irrigation Treatments:

1) Rainfed: Relying solely on natural rainfall for watering the cotton crops.  
2) Time Delay: Applying irrigation with a certain delay to simulate water stress conditions.  
3) Percent Deficit: Providing water at a reduced percentage of the crop's full water requirement.  
4) Fully Irrigated: Ensuring the crops receive the full amount of water needed for optimal growth.  

The focus of this project was to develop an algorithm to classify the irrigation treatment of a cotton image using computer vision techniques. This is an important task as cotton is a significant commercial crop in the United States, and it is essential to use the available water resources sustainably. With frequent droughts and declining groundwater levels, it is crucial to maximize crop water use efficiency and reduce water requirements in regions where water resources are deficient. Traditional irrigation scheduling methods may not accurately estimate crop water requirements, and this is where computer vision techniques can play a vital role.
 
To develop the algorithm, we used images from a DJI Phantom 4 drone with a real-time kinematic positioning (RTK) module to acquire high-resolution RGB images with centimeter level accuracy. The images were then processed using various computer vision techniques such as edge detection, morphological image processing, image segmentation, and image classification. We were provided with cotton RGB images and their corresponding labels in two separate folders, which we used to develop and test our classifier.
The first step in developing the algorithm was to detect the cotton in the center of the image. We achieved this by using edge detection techniques to identify the boundaries of the cotton. We then used morphological image processing to fill in the edges and segment out the cotton from the rest of the image. This allowed us to focus on the cotton and ignore the surrounding grass or other objects that may have been present in the image.
To classify the irrigation treatment, we used image segmentation techniques to separate the cotton into its different regions based on the color and texture of the cotton. We then used Convolutional Neural Network to train a classifier on the segmented images. We separated the cotton images into a training and testing dataset, ensuring that our model could classify the irrigation treatment accurately. Our test accuracy was 90%, which met the requirements for the project.

