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

    @ManyToOne
    @JoinColumn(name = "system_id")
    private AASystem AASystem;

    public Division() {
    }

    public Division(String name, double lat, double lng, AASystem AASystem) {
        this.name = name;
        this.lat = lat;
        this.lng = lng;
        this.AASystem = AASystem;
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

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public AASystem getAASystem() {
        return AASystem;
    }

    public void setAASystem(AASystem AASystem) {
        this.AASystem = AASystem;
    }

    @Override
    public String toString() {
        return name;
    }
}
