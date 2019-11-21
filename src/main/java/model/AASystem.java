package model;
import javax.persistence.*;

@Entity
@Table(name = "aa_system")
public class AASystem {
    @Column(name = "system_id")
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;
    private String name;
    private double radiusInnerLow, radiusOuterLow, radiusInnerMed, radiusOuterMed, radiusInnerHigh, radiusOuterHigh;

    public AASystem() {
    }

    public AASystem(String name, double radiusInnerLow, double radiusOuterLow, double radiusInnerMed, double radiusOuterMed, double radiusInnerHigh, double radiusOuterHigh) {
        this.name = name;
        this.radiusInnerLow = radiusInnerLow;
        this.radiusOuterLow = radiusOuterLow;
        this.radiusInnerMed = radiusInnerMed;
        this.radiusOuterMed = radiusOuterMed;
        this.radiusInnerHigh = radiusInnerHigh;
        this.radiusOuterHigh = radiusOuterHigh;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public double getRadiusInnerLow() {
        return radiusInnerLow;
    }

    public void setRadiusInnerLow(double radiusInnerLow) {
        this.radiusInnerLow = radiusInnerLow;
    }

    public double getRadiusOuterLow() {
        return radiusOuterLow;
    }

    public void setRadiusOuterLow(double radiusOuterLow) {
        this.radiusOuterLow = radiusOuterLow;
    }

    public double getRadiusInnerMed() {
        return radiusInnerMed;
    }

    public void setRadiusInnerMed(double radiusInnerMed) {
        this.radiusInnerMed = radiusInnerMed;
    }

    public double getRadiusOuterMed() {
        return radiusOuterMed;
    }

    public void setRadiusOuterMed(double radiusOuterMed) {
        this.radiusOuterMed = radiusOuterMed;
    }

    public double getRadiusInnerHigh() {
        return radiusInnerHigh;
    }

    public void setRadiusInnerHigh(double radiusInnerHigh) {
        this.radiusInnerHigh = radiusInnerHigh;
    }

    public double getRadiusOuterHigh() {
        return radiusOuterHigh;
    }

    public void setRadiusOuterHigh(double radiusOuterHigh) {
        this.radiusOuterHigh = radiusOuterHigh;
    }

    @Override
    public String toString() {
        return name;
    }
}
