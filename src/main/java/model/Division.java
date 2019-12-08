package model;
import com.google.gson.annotations.Expose;
import lombok.EqualsAndHashCode;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import javax.persistence.*;

@Entity
@Table(name = "division")
@Getter @Setter @NoArgsConstructor @EqualsAndHashCode
public class Division {

    @Column(name = "division_id")
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Expose
    private int id;
    @Expose
    private String name;
    @Expose
    private double lat;
    @Expose
    private double lng;

    @ManyToOne
    @JoinColumn(name = "system_id")
    @Expose
    private AASystem AASystem;

    public Division(String name, double lat, double lng, AASystem AASystem) {
        this.name = name;
        this.lat = lat;
        this.lng = lng;
        this.AASystem = AASystem;
    }

    @Override
    public String toString() {
        return name;
    }
}
