package com.web.beans;

public class Store {
    private String name;
    private String address;
    private String businessHours;
    private String phoneNumber;
    private String type;
    private String grade;
    private double distance;
    private String imageURL;
    private String notes;
    
    public Store() {}

    public Store(String name, String description, String address, String openingHours, String phoneNumber,
			String type) {
		this.name = name;
		this.address = address;
		this.businessHours = openingHours;
		this.phoneNumber = phoneNumber;
		this.type = type;
		this.distance = distance;
		this.imageURL = imageURL;
		this.grade = grade;
		this.notes = notes;
	}

	public String getGrade() {
		return grade;
	}

	public void setGrade(String grade) {
		this.grade = grade;
	}

	public String getNotes() {
		return notes;
	}

	public void setNotes(String notes) {
		this.notes = notes;
	}

	public String getImageURL() {
		return imageURL;
	}

	public void setImageURL(String imageURL) {
		this.imageURL = imageURL;
	}

	public double getDistance() {
		return distance;
	}

	public void setDistance(double distance) {
		this.distance = distance;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

    public String getName() {
        return name;
    }

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getBusinessHours() {
		return businessHours;
	}

	public void setBusinessHours(String businessHours) {
		this.businessHours = businessHours;
	}

	public String getPhoneNumber() {
		return phoneNumber;
	}

	public void setPhoneNumber(String phoneNumber) {
		this.phoneNumber = phoneNumber;
	}

	public void setName(String name) {
		this.name = name;
	}
}
