package vn.iotstar.model;

import java.io.Serializable;
import java.util.Date;
import jakarta.persistence.*;

@Entity
@Table(name = "[User]")
public class User implements Serializable {
    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    @Column(name = "email", length = 255)
    private String email;

    @Column(name = "username", length = 255, nullable = false)
    private String username;

    @Column(name = "fullname", length = 255)
    private String fullname;

    @Column(name = "password", length = 255, nullable = false)
    private String password;

    @Column(name = "avatar", length = 255)
    private String avatar;

    @Column(name = "images", length = 255)
    private String images;

    @Column(name = "roleid")
    private Integer roleid;

    @Column(name = "phone", length = 50)
    private String phone;

    @Temporal(TemporalType.DATE)
    @Column(name = "createdDate")
    private Date createdDate;

    @Transient
    private String otpCode;

    public User() {}

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public String getUsername() { return username; }
    public void setUsername(String username) { this.username = username; }

    public String getFullname() { return fullname; }
    public void setFullname(String fullname) { this.fullname = fullname; }

    public String getPassword() { return password; }
    public void setPassword(String password) { this.password = password; }

    public String getAvatar() { return avatar; }
    public void setAvatar(String avatar) { this.avatar = avatar; }

    public String getImages() { return images; }
    public void setImages(String images) { this.images = images; }

    public Integer getRoleid() { return roleid; }
    public void setRoleid(Integer roleid) { this.roleid = roleid; }

    public String getPhone() { return phone; }
    public void setPhone(String phone) { this.phone = phone; }

    public Date getCreatedDate() { return createdDate; }
    public void setCreatedDate(Date createdDate) { this.createdDate = createdDate; }

    public String getOtpCode() { return otpCode; }
    public void setOtpCode(String otpCode) { this.otpCode = otpCode; }
}