package myPackage.java.entity;

import myPackage.java.main.AI;
import myPackage.java.main.CheckCollision;
import myPackage.java.main.GamePanel;
import myPackage.java.main.KeyHandler;

import javax.imageio.ImageIO;
import java.awt.*;
import java.io.*;
import java.util.ArrayList;
import java.util.List;

public class Player extends Entity {
    GamePanel gp;
    public KeyHandler keyHandler;
    public int locationX;
    public int locationY;
    public Rectangle area;
    public CheckCollision checkCollision;
    Box[] boxes;
    int[][] mapTile;

    public Player(GamePanel gp, KeyHandler keyHandler, Box[] boxes) {

        this.gp = gp;
        this.keyHandler = keyHandler;
        this.tileSize = gp.tileSize;
        this.boxes = boxes;
        checkCollision = new CheckCollision(this, gp, boxes);
        this.mapTile = checkCollision.mapTile;
        setArea();
        setDefaultValue();
    }

    public void setArea() {
        area = new Rectangle(locationX, locationY, tileSize, tileSize);
    }

    public void setDefaultValue() {
        getDefaultImage();
    }

    public void getDefaultImage() {
        try {
            image = ImageIO.read(getClass().getResourceAsStream("/myPackage/assets/image/player.png"));
        } catch (IOException e) {
            System.out.println(e.getMessage());
        }
    }

    public void update() {
        if (keyHandler.upPressed == true || keyHandler.downPressed == true
                || keyHandler.leftPressed == true || keyHandler.rightPressed == true) {
            if (keyHandler.upPressed == true) {
                direction = "up";
                checkCollision.check(direction);
            } else if (keyHandler.downPressed == true) {
                direction = "down";
                checkCollision.check(direction);
            } else if (keyHandler.leftPressed == true) {
                direction = "left";
                checkCollision.check(direction);
            } else if (keyHandler.rightPressed == true) {
                direction = "right";
                checkCollision.check(direction);
            }
            if (collisionOn == false) {
                switch (direction) {
                    case "up":
                        locationY -= tileSize;
                        break;
                    case "down":
                        locationY += tileSize;
                        break;
                    case "left":
                        locationX -= tileSize;
                        break;
                    case "right":
                        locationX += tileSize;
                        break;
                }
            }
        }
    }

    public void draw(Graphics2D g2d) {
        g2d.drawImage(image, locationX, locationY, tileSize, tileSize, null);
        g2d.setColor(Color.red);
        if (checkCollision.checkWinGame()) {
            if (!keyHandler.AIString.equals("")) {
                String keyPath1 = "src/myPackage/assets/key/" + gp.numOfMap + ".txt";
                String keyPath2 = "/myPackage/assets/key/" + gp.numOfMap + ".txt";
                try {
                    InputStream inputStream = getClass().getResourceAsStream(keyPath2);
                    BufferedReader bufferedReader = new BufferedReader(new InputStreamReader(inputStream));

                    List<String> keyList = new ArrayList<>();
                    String line = bufferedReader.readLine();
                    while (line != null) {
                        keyList.add(line);
                        line = bufferedReader.readLine();
                    }
                    bufferedReader.close();
                    inputStream.close();
                    if (!keyList.contains(keyHandler.AIString)) {
                        FileWriter file = new FileWriter(keyPath1, true);
                        BufferedWriter bw = new BufferedWriter(file);
                        bw.newLine();
                        bw.write(keyHandler.AIString);
                        bw.close();
                        file.close();
                    }
                } catch (IOException e) {
                    System.out.println("An error occurred.");
                    e.printStackTrace();
                }
            }
            g2d.setColor(Color.white);
            g2d.setFont(new Font("Arial", Font.ITALIC | Font.BOLD, 50));
            FontMetrics metrics = gp.getFontMetrics(g2d.getFont());
            String string = "You win game";
            String point = "Point: " + String.valueOf(gp.AISupport.statistic());
            String assess = "Assess: " + gp.AISupport.assess();
            g2d.drawString(point, (gp.screenWidth - metrics.stringWidth(point)) / 2, 300);
            g2d.drawString(assess, (gp.screenWidth - metrics.stringWidth(assess)) / 2, 350);
            g2d.drawString(string, (gp.screenWidth - metrics.stringWidth(string)) / 2, 250);

//            gp.gameThread.stop();
        }
    }
}

