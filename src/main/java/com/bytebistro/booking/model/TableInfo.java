package com.bytebistro.booking.model;

public class TableInfo {

    private int tableId;
    private int tableNumber;
    private int seatingCapacity;

    // Default constructor
    public TableInfo() {}

    // Parameterized constructor
    public TableInfo(int tableId, int tableNumber, int seatingCapacity) {
        this.tableId         = tableId;
        this.tableNumber     = tableNumber;
        this.seatingCapacity = seatingCapacity;
    }

    // Getters
    public int getTableId() { return tableId; }
    public int getTableNumber() { return tableNumber; }
    public int getSeatingCapacity() { return seatingCapacity; }

    // Setters
    public void setTableId(int tableId) { this.tableId = tableId; }
    public void setTableNumber(int tableNumber) { this.tableNumber = tableNumber; }
    public void setSeatingCapacity(int seatingCapacity) { this.seatingCapacity = seatingCapacity; }
}