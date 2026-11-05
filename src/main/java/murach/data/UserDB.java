package murach.data;

import murach.business.User;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;

public class UserDB {

    private static Connection getConnection() throws Exception {
        Class.forName("org.postgresql.Driver");
        String url = System.getenv("DATABASE_URL");
        return DriverManager.getConnection(url);
    }

    public static int insert(User user, String ip) {
        String sql = "INSERT INTO email_subscribers (first_name, last_name, email, ip_address) VALUES (?, ?, ?, ?)";
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, user.getFirstName());
            ps.setString(2, user.getLastName());
            ps.setString(3, user.getEmail());
            ps.setString(4, ip);

            return ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
            return 0;
        }
    }
}