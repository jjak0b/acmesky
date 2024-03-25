CREATE DATABASE IF NOT EXISTS acmesky_db;

USE acmesky_db;

CREATE TABLE Airports (
    AirportID int NOT NULL AUTO_INCREMENT,
    Name VARCHAR(64) NOT NULL,
    City VARCHAR(32) NOT NULL,
    PRIMARY KEY (AirportID)
);

INSERT INTO Airports
    (AirportID,Name,City)
VALUES
    (1,"Aeroporto di Bologna-Guglielmo Marconi","Bologna"),
    (2,"Aeroporto del Salento", "Brindisi");


CREATE TABLE TravelPreferences (
    TravelPreferenceID int NOT NULL AUTO_INCREMENT,
    ProntogramID VARCHAR(256) NOT NULL,
    Budget DECIMAL(8, 2) NOT NULL,
    TravelDateStart DATE NOT NULL,
    TravelDateEnd DATE NOT NULL,
    AirportOriginID int NOT NULL,
    AirportDestinationID int NOT NULL,
    SeatsCount int NOT NULL DEFAULT(1),
    PRIMARY KEY (TravelPreferenceID),
    FOREIGN KEY (AirportOriginID) REFERENCES Airports(AirportID),
    FOREIGN KEY (AirportDestinationID) REFERENCES Airports(AirportID)
);

CREATE TABLE Customers (
    CustomerID int NOT NULL AUTO_INCREMENT,
    Name VARCHAR(64) NOT NULL,
    Surname VARCHAR(64) NOT NULL,
    PRIMARY KEY (CustomerID)
);

CREATE TABLE FlightCompanies (
    CompanyID int NOT NULL AUTO_INCREMENT,
    CompanyName VARCHAR(64) NOT NULL,
    PRIMARY KEY (CompanyID)
);

INSERT INTO FlightCompanies
    (CompanyID, CompanyName)
VALUES
    (1, "FlightCompany");

CREATE TABLE Flights (
    CompanyFlightID int NOT NULL,
    CompanyID int NOT NULL,
    AirportOriginID int NOT NULL,
    AirportDestinationID int NOT NULL,
    DepartDatetime DATETIME NOT NULL,
    ArrivalDatetime DATETIME NOT NULL,
    PassengerFlightPrice DECIMAL(8, 2) NOT NULL,
    AvailableSeats int NOT NULL DEFAULT(0),
    PRIMARY KEY (CompanyFlightID, CompanyID),
    FOREIGN KEY (CompanyID) REFERENCES FlightCompanies(CompanyID)
);

CREATE TABLE ReservedOffers (
    ReservedOfferCode int NOT NULL AUTO_INCREMENT,
    FlightBundleID int NOT NULL,
    CompanyID int NOT NULL,
    TravelPreferenceID int NOT NULL,
    EndReservationDatetime DATETIME DEFAULT NULL,
    CustomerFlightPrice DECIMAL(8, 2) NOT NULL,
    PRIMARY KEY (ReservedOfferCode),
    /*FOREIGN KEY (CompanyOfferID, CompanyID) REFERENCES FlightCompanytOffers(CompanyOfferID, CompanyID),*/
    FOREIGN KEY (CompanyID) REFERENCES FlightCompanies(CompanyID),
    FOREIGN KEY (TravelPreferenceID) REFERENCES TravelPreferences(TravelPreferenceID)
);

/*
CREATE TABLE FlightsForReservedOffers(
    ReservedOfferCode int NOT NULL,
    CompanyFlightID int NOT NULL,
    CompanyID int NOT NULL,
    PRIMARY KEY (ReservedOfferCode, CompanyFlightID, CompanyID),
    FOREIGN KEY (ReservedOfferCode) REFERENCES ReservedOffers(ReservedOfferCode),
    FOREIGN KEY (CompanyFlightID, CompanyID) REFERENCES Flights(CompanyFlightID, CompanyID)
};

CREATE TABLE CustomerBoughtOffers {
    CustomerID int NOT NULL, 
    ReservedOfferCode int NOT NULL,
    PRIMARY KEY (CustomerID, ReservedOfferCode),
    FOREIGN KEY (ReservedOfferCode) REFERENCES ReservedOffers(ReservedOfferCode),
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
}
*/