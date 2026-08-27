package vn.iotstar.entity;

import java.io.Serializable;
import java.util.List;
import jakarta.persistence.*;

@Entity
@Table(name = "categories")
@NamedQuery(name = "Category.findAll", query = "SELECT c FROM Category c")
public class Category implements Serializable {
    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "categoryId")
    private int categoryId;

    @Column(name = "categoryname", columnDefinition = "NVARCHAR(255) NULL")
    private String categoryname;

    @Column(name = "images", columnDefinition = "NVARCHAR(500) NULL")
    private String images;

    @Column(name = "status")
    private int status;

    @OneToMany(mappedBy = "category", cascade = CascadeType.ALL)
    private List<Video> videos;

    public Category() {}

    public Category(int categoryId, String categoryname, String images, int status, List<Video> videos) {
        this.categoryId = categoryId;
        this.categoryname = categoryname;
        this.images = images;
        this.status = status;
        this.videos = videos;
    }

    public int getCategoryId() {
        return this.categoryId;
    }

    public void setCategoryId(int categoryId) {
        this.categoryId = categoryId;
    }

    public String getCategoryname() {
        return this.categoryname;
    }

    public void setCategoryname(String categoryname) {
        this.categoryname = categoryname;
    }

    public String getImages() {
        return this.images;
    }

    public void setImages(String images) {
        this.images = images;
    }

    public int getStatus() {
        return this.status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    public List<Video> getVideos() {
        return this.videos;
    }

    public void setVideos(List<Video> videos) {
        this.videos = videos;
    }

    public Video addVideo(Video video) {
        getVideos().add(video);
        video.setCategory(this);
        return video;
    }

    public Video removeVideo(Video video) {
        getVideos().remove(video);
        video.setCategory(null);
        return video;
    }
}