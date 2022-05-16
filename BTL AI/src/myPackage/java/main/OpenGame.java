package myPackage.java.main;

import javax.swing.*;
import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;

public class OpenGame {

    public JFrame frame;
    public JFrame window;
    public static final int SCREEN_WIDTH = 600;
    public static final int SCREEN_HEIGHT = 600;
    public JButton bStartGame;
    public JButton left;
    public JButton right;
    public JLabel label;
    public JLabel intro;
    public int count = 1;
    public OpenGame() {
        ActionListener buttonListener = new ActionListener() {

            @Override
            public void actionPerformed(ActionEvent e) {
                runGame(count);
            }
        };

        ActionListener bLeftListener = new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                count++;
                if (count == 11) {
                    count = 1;
                }
                label.setText("Level " + count);
            }
        };

        ActionListener bRightListener = new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                count--;
                if (count == 0) {
                    count = 10;
                }
                label.setText("Level " + count);
            }
        };

        Font font = new Font("Arial", Font.ITALIC | Font.BOLD, 20);

        // button
        bStartGame = new JButton("Start game");
        bStartGame.addActionListener(buttonListener);
        bStartGame.setBorder(BorderFactory.createEmptyBorder());
        bStartGame.setBackground(new Color(50, 50, 50));
        bStartGame.setForeground(Color.WHITE);
        bStartGame.setFont(font);
        bStartGame.setFocusPainted(false);
        bStartGame.setBounds((SCREEN_WIDTH - 120) / 2, 300, 120, 30);

        left = new JButton("left");
        left.addActionListener(bLeftListener);
        left.setBorder(BorderFactory.createEmptyBorder());
        left.setBackground(new Color(50, 50, 50));
        left.setForeground(Color.WHITE);
        left.setFont(font);
        left.setFocusPainted(false);
        left.setBounds((SCREEN_WIDTH + bStartGame.getWidth()) / 2 - 10, 240, 60, 30);

        right = new JButton("right");
        right.addActionListener(bRightListener);
        right.setBorder(BorderFactory.createEmptyBorder());
        right.setBackground(new Color(50, 50, 50));
        right.setForeground(Color.WHITE);
        right.setFont(font);
        right.setFocusPainted(false);
        right.setBounds((SCREEN_WIDTH) / 2 - bStartGame.getWidth(), 240, 60, 30);

        label = new JLabel();
        label.setText("Level " + count);
        label.setBorder(BorderFactory.createEmptyBorder());
        label.setBackground(new Color(50, 50, 50));
        label.setForeground(Color.WHITE);
        label.setFont(font);
        label.setBounds((SCREEN_WIDTH - 80) / 2, 240, 80, 30);

        intro = new JLabel();
        intro.setText("Game Sokoban");
        intro.setBorder(BorderFactory.createEmptyBorder());
        intro.setBackground(new Color(50, 50, 50));
        intro.setForeground(Color.RED);
        intro.setFont(new Font("Arial", Font.ITALIC | Font.BOLD, 30));
        intro.setBounds((SCREEN_WIDTH - 240) / 2, 100, 240, 50);

        // frame
        frame = new JFrame();
        frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        frame.setSize(SCREEN_WIDTH, SCREEN_HEIGHT);
        frame.getContentPane().setBackground(new Color(50, 50, 50));
        frame.setResizable(false);
        frame.setLayout(null);
        frame.setLocationRelativeTo(null);

        frame.add(bStartGame);
        frame.add(left);
        frame.add(right);
        frame.add(label);
        frame.add(intro);
        frame.setVisible(true);

    }

    public void runGame(int count) {
        window = new JFrame();
        window.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        window.setTitle("Game sokoban");
        window.setResizable(false);

        GamePanel gamePanel = new GamePanel(this);
        window.add(gamePanel);
        window.pack();
        window.setLocationRelativeTo(null);
        window.setLayout(null);
        window.setVisible(true);
        gamePanel.startGame();
    }
}
