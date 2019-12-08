package model;

import com.google.gson.annotations.Expose;
import lombok.EqualsAndHashCode;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import javax.persistence.*;

@Entity
@Table(name = "aa_radius",
        uniqueConstraints =
        @UniqueConstraint(columnNames =
                {"system_id", "height"}))
@Getter @Setter @NoArgsConstructor @EqualsAndHashCode
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

    public AARadius(model.AASystem AASystem, double height, double radiusInner, double radiusOuter) {
        this.AASystem = AASystem;
        this.height = height;
        this.radiusInner = radiusInner;
        this.radiusOuter = radiusOuter;
    }
}
