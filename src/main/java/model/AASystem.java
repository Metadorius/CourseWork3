package model;

import com.google.gson.annotations.Expose;
import lombok.EqualsAndHashCode;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import javax.persistence.*;
import java.util.List;

@Entity
@Table(name = "aa_system")
@Getter @Setter @NoArgsConstructor @EqualsAndHashCode
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

    public AASystem(String name, double rocketSpeed, List<AARadius> radii) {
        this.name = name;
        this.rocketSpeed = rocketSpeed;
        this.radii = radii;
    }

    @Override
    public String toString() {
        return name;
    }
}
