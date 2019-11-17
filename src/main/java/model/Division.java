package model;
import javax.persistence.*;

@Entity
@Table(name = "division")
public class Division {

    @Column(name = "division_id")
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;
    private String name;
    private double lat, lng;
    private String type; // temp

    public Division() {
    }

    public Division(String name, double lat, double lng, String type) {
        this.name = name;
        this.lat = lat;
        this.lng = lng;
        this.type = type;
    }

    public Division(int id, String name, double lat, double lng, String type) {
        this.id = id;
        this.name = name;
        this.lat = lat;
        this.lng = lng;
        this.type = type;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public double getLat() {
        return lat;
    }

    public void setLat(double lat) {
        this.lat = lat;
    }

    public double getLng() {
        return lng;
    }

    public void setLng(double lng) {
        this.lng = lng;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }
}
