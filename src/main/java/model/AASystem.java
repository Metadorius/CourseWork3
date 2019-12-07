package model;

import com.google.gson.annotations.Expose;

import javax.persistence.*;
import java.util.List;

@Entity
@Table(name = "aa_system")
public class AASystem {
    @Column(name = "system_id")
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Expose
    private int id;
    @Expose
    private String name;
    @Expose
    private double rocketSpeed;

    public AASystem(String name, double rocketSpeed) {
        this.name = name;
        this.rocketSpeed = rocketSpeed;
    }

    @OneToMany(mappedBy = "AASystem", fetch = FetchType.EAGER)
    @Expose
    private List<AARadius> radii;

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

    public double getRocketSpeed() {
        return rocketSpeed;
    }

    public void setRocketSpeed(double rocketSpeed) {
        this.rocketSpeed = rocketSpeed;
    }

    public List<AARadius> getRadii() {
        return radii;
    }

    public void setRadii(List<AARadius> radii) {
        this.radii = radii;
    }

    public AASystem(String name, double rocketSpeed, List<AARadius> radii) {
        this.name = name;
        this.rocketSpeed = rocketSpeed;
        this.radii = radii;
    }

    public AASystem() {
    }

    @Override
    public String toString() {
        return name;
    }
}
