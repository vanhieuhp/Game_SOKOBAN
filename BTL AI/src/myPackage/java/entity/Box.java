package myPackage.java.entity;

import javax.imageio.ImageIO;
import java.awt.image.BufferedImage;
import java.io.IOException;

public class Box extends Entity {

    public int locationX;
    public int locationY;
    public BufferedImage image = null;

    public Box() {
        setImage();
    }

    public void setImage() {
        try {
            image = ImageIO.read(getClass().getResourceAsStream("/myPackage/assets/image/box.png"));
        } catch (IOException e) {
            System.out.println(e.getMessage());
        }
    }

}
