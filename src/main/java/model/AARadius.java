package model;

import com.google.gson.annotations.Expose;

import javax.persistence.*;

@Entity
@Table(name = "aa_radius",
        uniqueConstraints =
        @UniqueConstraint(columnNames =
                {"system_id", "height"}))
public class AARadius {
    @Column(name = "radius_id")
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Expose
    private int id;

    @ManyToOne
    @JoinColumn(name = "system_id")
    @Expose(serialize = false, deserialize = false)
    private AASystem AASystem;

    @Expose
    private double height;
    @Expose
    private double radiusInner;
    @Expose
    private double radiusOuter;

    @Override
    public String toString() {
        return height + ": " + radiusInner + "-" + radiusOuter;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public model.AASystem getAASystem() {
        return AASystem;
    }

    public void setAASystem(model.AASystem AASystem) {
        this.AASystem = AASystem;
    }

    public double getRadiusInner() {
        return radiusInner;
    }

    public void setRadiusInner(double radiusInner) {
        this.radiusInner = radiusInner;
    }

    public double getRadiusOuter() {
        return radiusOuter;
    }

    public void setRadiusOuter(double radiusOuter) {
        this.radiusOuter = radiusOuter;
    }

    public AARadius(model.AASystem AASystem, double height, double radiusInner, double radiusOuter) {
        this.AASystem = AASystem;
        this.height = height;
        this.radiusInner = radiusInner;
        this.radiusOuter = radiusOuter;
    }

    public AARadius() {
    }

    public double getHeight() {
        return height;
    }

    public void setHeight(double height) {
        this.height = height;
    }
}
