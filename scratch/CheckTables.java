import com.bytebistro.utils.DBConnection;
import java.sql.*;

public class CheckTables {
    public static void main(String[] args) {
        try (Connection conn = DBConnection.getConnection()) {
            Statement st = conn.createStatement();
            ResultSet rs = st.executeQuery("SELECT COUNT(*) FROM table_info");
            if (rs.next()) {
                System.out.println("Total Tables: " + rs.getInt(1));
            }
            
            rs = st.executeQuery("SELECT * FROM menu_items WHERE is_available = true");
            System.out.println("Available Menu Items:");
            while(rs.next()) {
                System.out.println("- " + rs.getString("name") + " (" + rs.getString("item_type") + ")");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
