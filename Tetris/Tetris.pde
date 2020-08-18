import java.util.Vector;

final color RED = color(255, 0, 0),
            GREEN = color(0, 255, 0),
            BLUE = color(0, 0, 255),
            YELLOW = color(255, 255, 0),
            MAGENTA = color(255, 0, 255),
            CYAN = color(0, 255, 255),
            BLACK = color(0),
            WHITE = color(255),
            GRAY = color(128);

class Tuple<T> {
    T x, y;

    Tuple(T _x, T _y) {
        x = _x;
        y = _y;
    }
}

interface Shape {
    float area();
    Shape setVelocity(float vx, float vy);
    Shape setVelocity(Tuple<Float> t);
    Tuple<Float> getVelocity();
    Shape invertVelocityX();
    Shape invertVelocityY();

    Shape setColor(color col);
    Shape setColor(float val);
    Shape setColor(float r, float g, float b);
    color getColor();

    Shape moveTo(float xpos, float ypos);
    Shape move(float dx, float dy);
    Tuple<Float> getPos();

    Shape scale(float size);

    Shape show();
    Shape showc();

    boolean contains(float xpos, float ypos);
}

class Rect implements Shape {
    private float x, y, cx, cy, w, h;
    private color c;
    private Tuple<Float> v;

    Rect() {
        x = 0;
        y = 0;
        w = width;
        h = height;
        cx = x + 0.5 * w;
        cy = y + 0.5 * h;
        v = new Tuple(0.0, 0.0);
        c = WHITE;
    }

    Rect(float xpos, float ypos, float wid, float hei) {
        x = xpos;
        y = ypos;
        w = wid;
        h = hei;
        cx = x + 0.5 * w;
        cy = y + 0.5 * h;
        v = new Tuple(0.0, 0.0);
        c = WHITE;
    }

    Rect(float xpos, float ypos, float wid, float hei, color col) {
        x = xpos;
        y = ypos;
        w = wid;
        h = hei;
        cx = x + 0.5 * w;
        cy = y + 0.5 * h;
        v = new Tuple(0.0, 0.0);
        c = col;
    }

    Rect(float xpos, float ypos, float wid, float hei, float red, float green, float blue) {
        x = xpos;
        y = ypos;
        w = wid;
        h = hei;
        cx = x + 0.5 * w;
        cy = y + 0.5 * h;
        v = new Tuple(0.0, 0.0);
        c = color(red, green, blue);
    }

    Rect(Tuple<Float> p, float wid, float hei) {
        x = p.x;
        y = p.y;
        w = wid;
        h = hei;
        cx = x + 0.5 * w;
        cy = y + 0.5 * h;
        v = new Tuple(0.0, 0.0);
        c = WHITE;
    }

    Rect(Tuple<Float> p, float wid, float hei, color col) {
        x = p.x;
        y = p.y;
        w = wid;
        h = hei;
        cx = x + 0.5 * w;
        cy = y + 0.5 * h;
        v = new Tuple(0.0, 0.0);
        c = col;
    }

    Rect(Tuple<Float> p, float wid, float hei, float red, float green, float blue) {
        x = p.x;
        y = p.y;
        w = wid;
        h = hei;
        cx = x + 0.5 * w;
        cy = y + 0.5 * h;
        v = new Tuple(0.0, 0.0);
        c = color(red, green, blue);
    }

    float area() {
        return w * h;
    }

    Rect setVelocity(float vx, float vy) {
        v = new Tuple(vx, vy);
        return this;
    }

    Rect setVelocity(Tuple<Float> t) {
        v = t;
        return this;
    }

    Tuple<Float> getVelocity() {
        return v;
    }

    Rect invertVelocityX() {
        v.x = -v.x;
        return this;
    }

    Rect invertVelocityY() {
        v.y = -v.y;
        return this;
    }

    Rect setColor(color col) {
        c = col;
        return this;
    }

    Rect setColor(float val) {
        c = color(val);
        return this;
    }

    Rect setColor(float red, float green, float blue) {
        c = color(red, green, blue);
        return this;
    }

    color getColor() {
        return c;
    }

    Rect setCenter(float cxpos, float cypos) {
        cx = cxpos;
        cy = cypos;
        x = cx - 0.5 * w;
        y = cy - 0.5 * h;
        return this;
    }

    Tuple<Float> getCenter() {
        return new Tuple(cx, cy);
    }

    Rect moveTo(float xpos, float ypos) {
        x = xpos;
        y = ypos;
        return this;
    }

    Rect moveTo(Tuple<? extends Number> t) {
        x = t.x.floatValue();
        y = t.y.floatValue();
        return this;
    }

    Rect move(float dx, float dy) {
        x += dx;
        y += dy;
        return this;
    }

    Rect move(Tuple<? extends Number> t) {
        x += t.x.floatValue();
        y += t.y.floatValue();
        return this;
    }

    Tuple<Float> getPos() {
        return new Tuple(x, y);
    }

    Rect scale(float size) {
        return this.scale(sqrt(size), sqrt(size));
    }

    Rect scale(float xsize, float ysize) {
        w *= xsize;
        h *= ysize;
        return this;
    }

    Rect setWidth(float wid) {
        return this.scale(wid, 1);
    }

    float getWidth() {
        return w;
    }

    Rect setHeight(float hei) {
        return this.scale(1, hei);
    }

    float getHeight() {
        return h;
    }

    Rect show() {
        rect(x, y, w, h);
        return this;
    }

    Rect showc() {
        fill(c);
        return show();
    }

    boolean contains(float xpos, float ypos) {
        return x <= xpos && (x + w) >= xpos && y <= ypos && (y + h) >= ypos;
    }

    boolean hits(Rect _r) {
        float rx = _r.getPos().x, ry = _r.getPos().y, rw = _r.getWidth(), rh = _r.getHeight();
        return ((x < rx) ? (x + w > rx) : (x < rx + rw)) && ((y < ry) ? (y + h > ry) : (y < ry + rh));
    }

    Tuple<Boolean> hitsWall() {
        Tuple<Boolean> ret = new Tuple(this.contains(-stageWidth / 20, y + 0.5 * h) || this.contains(stageWidth + stageWidth / 20, y + 0.5 * h), this.contains(x + 0.5 * w, 0) || this.contains(x + 0.5 * w, height));
        // if(x <= 0) x = 0;
        // if(x >= width) x = width;
        // if(y <= 0) y = 0;
        // if(y >= height) y = height;
        return ret;
    }
}

class Block {
    int px, py, t, rotateState, lockDown;
    Rect r1, r2, r3, r4;
    boolean active, v1, v2, v3, v4, stop, spinFlag;
    color c;

    Block show() {
        if(v1) r1.showc();
        if(v2) r2.showc();
        if(v3) r3.showc();
        if(v4) r4.showc();
        return this;
    }

    Rect getR1() {
        return r1;
    }

    Rect getR2() {
        return r2;
    }

    Rect getR3() {
        return r3;
    }

    Rect getR4() {
        return r4;
    }

    boolean getV1() {
        return v1;
    }

    boolean getV2() {
        return v2;
    }

    boolean getV3() {
        return v3;
    }

    boolean getV4() {
        return v4;
    }

    boolean hits(Block b) {
        Vector<Rect> br = new Vector(), r = new Vector();
        Vector<Boolean> vbr = new Vector(), vr = new Vector();
        float dx = 0.0, dy = 0.0;
        int i = 0, j = 0;
        br.add(b.getR1()); vbr.add(b.getV1()); r.add(r1); vr.add(v1);
        br.add(b.getR2()); vbr.add(b.getV2()); r.add(r2); vr.add(v2);
        br.add(b.getR3()); vbr.add(b.getV3()); r.add(r3); vr.add(v3);
        br.add(b.getR4()); vbr.add(b.getV4()); r.add(r4); vr.add(v4);
        for(Rect bri : br) {
            for(Rect ri : r) {
                dx = abs(bri.getPos().x - ri.getPos().x);
                dy = abs(bri.getPos().y - ri.getPos().y);
                if(vbr.get(i).booleanValue() && dx < stageWidth / 20 && dy < height / 40) return true;
                j++;
            }
            j = 0;
            i++;
        }
        return false;
    }

    Block move() {
        if(lockDown >= 15) {
            active = false;
            t = 0;
        }
        if(py > 2 && (r1.hitsWall().y || r3.hitsWall().y || r4.hitsWall().y) || !active || stop) {
            if(stop) {
                stop = false;
                py++;
                r1.move(0, stageHeight / 20);
                r2.move(0, stageHeight / 20);
                r3.move(0, stageHeight / 20);
                r4.move(0, stageHeight / 20);
                for(Block b : blocks) {
                    if(hits(b)) {
                        stop = true;
                        break;
                    }
                }
                if(stop) {
                    py--;
                    r1.move(0, -stageHeight / 20);
                    r2.move(0, -stageHeight / 20);
                    r3.move(0, -stageHeight / 20);
                    r4.move(0, -stageHeight / 20);
                    if(t != 0 && millis() - t > 500) {
                        active = false;
                        t = 0;
                    }
                    if(t == 0) t = millis();
                    return this;
                }
                else {
                    lockDown = 0;
                    spinFlag = false;
                    t = 0;
                }
            }
            else {
                if(t != 0 && millis() - t > 500) {
                    active = false;
                    t = 0;
                }
                if(t == 0) t = millis();
                return this;
            }
        }
        
        stop = false;
        py++;
        r1.move(0, stageHeight / 20);
        r2.move(0, stageHeight / 20);
        r3.move(0, stageHeight / 20);
        r4.move(0, stageHeight / 20);
        for(Block b : blocks) {
            if(hits(b)) {
                stop = true;
                break;
            }
        }
        if(stop) {
            if(t != 0 && millis() - t > 500) {
                active = false;
                t = 0;
            }
            if(t == 0) {
                t = millis();
                py--;
                r1.move(0, -stageHeight / 20);
                r2.move(0, -stageHeight / 20);
                r3.move(0, -stageHeight / 20);
                r4.move(0, -stageHeight / 20);
            }
        }
        else {
            lockDown = 0;
            spinFlag = false;
            t = 0;
        }
        return this;
    }

    Block move2() {
        py++;
        r1.move(0, stageHeight / 20);
        r2.move(0, stageHeight / 20);
        r3.move(0, stageHeight / 20);
        r4.move(0, stageHeight / 20);
        return this;
    }

    Block moveToBottom() {
        stop = false;
        py++;
        r1.move(0, stageHeight / 20);
        r2.move(0, stageHeight / 20);
        r3.move(0, stageHeight / 20);
        r4.move(0, stageHeight / 20);
        for(Block b : blocks) {
            if(hits(b)) {
                stop = true;
                break;
            }
        }
        py--;
        r1.move(0, -stageHeight / 20);
        r2.move(0, -stageHeight / 20);
        r3.move(0, -stageHeight / 20);
        r4.move(0, -stageHeight / 20);
        while(!(py > 2 && (r1.hitsWall().y || r3.hitsWall().y || r4.hitsWall().y) || !active || stop)) {
            score += 2;
            move();
        }
        active = false;
        r1.setColor(c);
        r2.setColor(c);
        r3.setColor(c);
        r4.setColor(c);
        return this;
    }

    Block moveToBottom2() {
        while(!(py > 2 && (r1.hitsWall().y || r3.hitsWall().y || r4.hitsWall().y) || !active || stop)) move();
        active = false;
        r1.setColor(c);
        r2.setColor(c);
        r3.setColor(c);
        r4.setColor(c);
        return this;
    }

    Block fix(int line) {
        if(r1.getPos().y < line * stageHeight / 20) r1.move(0, stageHeight / 20);
        if(r2.getPos().y < line * stageHeight / 20) r2.move(0, stageHeight / 20);
        if(r3.getPos().y < line * stageHeight / 20) r3.move(0, stageHeight / 20);
        if(r4.getPos().y < line * stageHeight / 20) r4.move(0, stageHeight / 20);
        return this;
    }

    Block moveRight() {
        if(px >= 7 && (r1.hitsWall().x || r3.hitsWall().x || r4.hitsWall().x) || !active) return this;
        lockDown++;
        px++;
        r1.move(stageWidth / 10, 0);
        r2.move(stageWidth / 10, 0);
        r3.move(stageWidth / 10, 0);
        r4.move(stageWidth / 10, 0);
        boolean f = false;
        for(Block b : blocks) {
            if(hits(b)) {
                f = true;
                break;
            }
        }
        if(f || (r1.hitsWall().x || r3.hitsWall().x || r4.hitsWall().x)) {
            px--;
            r1.move(-stageWidth / 10, 0);
            r2.move(-stageWidth / 10, 0);
            r3.move(-stageWidth / 10, 0);
            r4.move(-stageWidth / 10, 0);
            lockDown--;
        }
        else spinFlag = false;
        return this;
    }

    Block moveLeft() {
        if(px <= 2 && (r1.hitsWall().x || r3.hitsWall().x || r4.hitsWall().x) || !active) return this;
        lockDown++;
        px--;
        r1.move(-stageWidth / 10, 0);
        r2.move(-stageWidth / 10, 0);
        r3.move(-stageWidth / 10, 0);
        r4.move(-stageWidth / 10, 0);
        boolean f = false;
        for(Block b : blocks) {
            if(hits(b)) {
                f = true;
                break;
            }
        }
        if(f || (r1.hitsWall().x || r3.hitsWall().x || r4.hitsWall().x)) {
            px++;
            r1.move(stageWidth / 10, 0);
            r2.move(stageWidth / 10, 0);
            r3.move(stageWidth / 10, 0);
            r4.move(stageWidth / 10, 0);
            lockDown--;
        }
        else spinFlag = false;
        return this;
    }

    Block moveX(int dx) {
        px += dx;
        r1.move(dx, 0);
        r2.move(dx, 0);
        r3.move(dx, 0);
        r4.move(dx, 0);
        return this;
    }

    Block rotateLeft() {
        if(!active) return this;
        boolean f = false;
        lockDown++;
        r1.moveTo(r1.getPos().y - py * stageHeight / 20 + px * stageWidth / 10, px * stageWidth / 10 - r1.getPos().x + py * stageHeight / 20);
        r3.moveTo(r3.getPos().y - py * stageHeight / 20 + px * stageWidth / 10, px * stageWidth / 10 - r3.getPos().x + py * stageHeight / 20);
        r4.moveTo(r4.getPos().y - py * stageHeight / 20 + px * stageWidth / 10, px * stageWidth / 10 - r4.getPos().x + py * stageHeight / 20);
        rotateState++;
        if(rotateState == 4) rotateState = 0;
        switch(rotateState) {
            case 0:
                f = false;
                for(Block b : blocks) {
                    if(hits(b)) {
                        f = true;
                        break;
                    }
                }
                f = f || (r1.hitsWall().x || r2.hitsWall().x || r3.hitsWall().x || r4.hitsWall().x);
                if(!f) return this;
                px++;
                r1.move(stageWidth / 10, 0);
                r2.move(stageWidth / 10, 0);
                r3.move(stageWidth / 10, 0);
                r4.move(stageWidth / 10, 0);
                f = false;
                for(Block b : blocks) {
                    if(hits(b)) {
                        f = true;
                        break;
                    }
                }
                f = f || (r1.hitsWall().x || r2.hitsWall().x || r3.hitsWall().x || r4.hitsWall().x);
                if(!f) return this;
                py++;
                r1.move(0, stageHeight / 20);
                r2.move(0, stageHeight / 20);
                r3.move(0, stageHeight / 20);
                r4.move(0, stageHeight / 20);
                f = false;
                for(Block b : blocks) {
                    if(hits(b)) {
                        f = true;
                        break;
                    }
                }
                f = f || (r1.hitsWall().x || r2.hitsWall().x || r3.hitsWall().x || r4.hitsWall().x);
                if(!f) return this;
                px--;
                py -= 3;
                r1.move(-stageWidth / 10, -3 * stageHeight / 20);
                r2.move(-stageWidth / 10, -3 * stageHeight / 20);
                r3.move(-stageWidth / 10, -3 * stageHeight / 20);
                r4.move(-stageWidth / 10, -3 * stageHeight / 20);
                f = false;
                for(Block b : blocks) {
                    if(hits(b)) {
                        f = true;
                        break;
                    }
                }
                f = f || (r1.hitsWall().x || r2.hitsWall().x || r3.hitsWall().x || r4.hitsWall().x);
                if(!f) return this;
                px++;
                r1.move(stageWidth / 10, 0);
                r2.move(stageWidth / 10, 0);
                r3.move(stageWidth / 10, 0);
                r4.move(stageWidth / 10, 0);
                f = false;
                for(Block b : blocks) {
                    if(hits(b)) {
                        f = true;
                        break;
                    }
                }
                f = f || (r1.hitsWall().x || r2.hitsWall().x || r3.hitsWall().x || r4.hitsWall().x);
                if(!f) return this;
                px--;
                py += 2;
                r1.move(-stageWidth / 10, 2 * stageHeight / 20);
                r2.move(-stageWidth / 10, 2 * stageHeight / 20);
                r3.move(-stageWidth / 10, 2 * stageHeight / 20);
                r4.move(-stageWidth / 10, 2 * stageHeight / 20);
                rotateState = 3;
                break;

            case 1:
                f = false;
                for(Block b : blocks) {
                    if(hits(b)) {
                        f = true;
                        break;
                    }
                }
                f = f || (r1.hitsWall().x || r2.hitsWall().x || r3.hitsWall().x || r4.hitsWall().x);
                if(!f) return this;
                px++;
                r1.move(stageWidth / 10, 0);
                r2.move(stageWidth / 10, 0);
                r3.move(stageWidth / 10, 0);
                r4.move(stageWidth / 10, 0);
                f = false;
                for(Block b : blocks) {
                    if(hits(b)) {
                        f = true;
                        break;
                    }
                }
                f = f || (r1.hitsWall().x || r2.hitsWall().x || r3.hitsWall().x || r4.hitsWall().x);
                if(!f) return this;
                py--;
                r1.move(0, -stageHeight / 20);
                r2.move(0, -stageHeight / 20);
                r3.move(0, -stageHeight / 20);
                r4.move(0, -stageHeight / 20);
                f = false;
                for(Block b : blocks) {
                    if(hits(b)) {
                        f = true;
                        break;
                    }
                }
                f = f || (r1.hitsWall().x || r2.hitsWall().x || r3.hitsWall().x || r4.hitsWall().x);
                if(!f) return this;
                px--;
                py += 3;
                r1.move(-stageWidth / 10, 3 * stageHeight / 20);
                r2.move(-stageWidth / 10, 3 * stageHeight / 20);
                r3.move(-stageWidth / 10, 3 * stageHeight / 20);
                r4.move(-stageWidth / 10, 3 * stageHeight / 20);
                f = false;
                for(Block b : blocks) {
                    if(hits(b)) {
                        f = true;
                        break;
                    }
                }
                f = f || (r1.hitsWall().x || r2.hitsWall().x || r3.hitsWall().x || r4.hitsWall().x);
                if(!f) return this;
                px++;
                r1.move(stageWidth / 10, 0);
                r2.move(stageWidth / 10, 0);
                r3.move(stageWidth / 10, 0);
                r4.move(stageWidth / 10, 0);
                f = false;
                for(Block b : blocks) {
                    if(hits(b)) {
                        f = true;
                        break;
                    }
                }
                f = f || (r1.hitsWall().x || r2.hitsWall().x || r3.hitsWall().x || r4.hitsWall().x);
                if(!f) return this;
                px--;
                py -= 2;
                r1.move(-stageWidth / 10, -2 * stageHeight / 20);
                r2.move(-stageWidth / 10, -2 * stageHeight / 20);
                r3.move(-stageWidth / 10, -2 * stageHeight / 20);
                r4.move(-stageWidth / 10, -2 * stageHeight / 20);
                rotateState = 0;
                break;

            case 2:
                f = false;
                for(Block b : blocks) {
                    if(hits(b)) {
                        f = true;
                        break;
                    }
                }
                f = f || (r1.hitsWall().x || r2.hitsWall().x || r3.hitsWall().x || r4.hitsWall().x);
                if(!f) return this;
                px--;
                r1.move(-stageWidth / 10, 0);
                r2.move(-stageWidth / 10, 0);
                r3.move(-stageWidth / 10, 0);
                r4.move(-stageWidth / 10, 0);
                f = false;
                for(Block b : blocks) {
                    if(hits(b)) {
                        f = true;
                        break;
                    }
                }
                f = f || (r1.hitsWall().x || r2.hitsWall().x || r3.hitsWall().x || r4.hitsWall().x);
                if(!f) return this;
                py++;
                r1.move(0, stageHeight / 20);
                r2.move(0, stageHeight / 20);
                r3.move(0, stageHeight / 20);
                r4.move(0, stageHeight / 20);
                f = false;
                for(Block b : blocks) {
                    if(hits(b)) {
                        f = true;
                        break;
                    }
                }
                f = f || (r1.hitsWall().x || r2.hitsWall().x || r3.hitsWall().x || r4.hitsWall().x);
                if(!f) return this;
                px++;
                py -= 3;
                r1.move(stageWidth / 10, -3 * stageHeight / 20);
                r2.move(stageWidth / 10, -3 * stageHeight / 20);
                r3.move(stageWidth / 10, -3 * stageHeight / 20);
                r4.move(stageWidth / 10, -3 * stageHeight / 20);
                f = false;
                for(Block b : blocks) {
                    if(hits(b)) {
                        f = true;
                        break;
                    }
                }
                f = f || (r1.hitsWall().x || r2.hitsWall().x || r3.hitsWall().x || r4.hitsWall().x);
                if(!f) return this;
                px--;
                r1.move(-stageWidth / 10, 0);
                r2.move(-stageWidth / 10, 0);
                r3.move(-stageWidth / 10, 0);
                r4.move(-stageWidth / 10, 0);
                f = false;
                for(Block b : blocks) {
                    if(hits(b)) {
                        f = true;
                        break;
                    }
                }
                f = f || (r1.hitsWall().x || r2.hitsWall().x || r3.hitsWall().x || r4.hitsWall().x);
                if(!f) return this;
                px++;
                py += 2;
                r1.move(stageWidth / 10, 2 * stageHeight / 20);
                r2.move(stageWidth / 10, 2 * stageHeight / 20);
                r3.move(stageWidth / 10, 2 * stageHeight / 20);
                r4.move(stageWidth / 10, 2 * stageHeight / 20);
                rotateState = 1;
                break;

            case 3:
                f = false;
                for(Block b : blocks) {
                    if(hits(b)) {
                        f = true;
                        break;
                    }
                }
                f = f || (r1.hitsWall().x || r2.hitsWall().x || r3.hitsWall().x || r4.hitsWall().x);
                if(!f) return this;
                px--;
                r1.move(-stageWidth / 10, 0);
                r2.move(-stageWidth / 10, 0);
                r3.move(-stageWidth / 10, 0);
                r4.move(-stageWidth / 10, 0);
                f = false;
                for(Block b : blocks) {
                    if(hits(b)) {
                        f = true;
                        break;
                    }
                }
                f = f || (r1.hitsWall().x || r2.hitsWall().x || r3.hitsWall().x || r4.hitsWall().x);
                if(!f) return this;
                py--;
                r1.move(0, -stageHeight / 20);
                r2.move(0, -stageHeight / 20);
                r3.move(0, -stageHeight / 20);
                r4.move(0, -stageHeight / 20);
                f = false;
                for(Block b : blocks) {
                    if(hits(b)) {
                        f = true;
                        break;
                    }
                }
                f = f || (r1.hitsWall().x || r2.hitsWall().x || r3.hitsWall().x || r4.hitsWall().x);
                if(!f) return this;
                px++;
                py += 3;
                r1.move(stageWidth / 10, 3 * stageHeight / 20);
                r2.move(stageWidth / 10, 3 * stageHeight / 20);
                r3.move(stageWidth / 10, 3 * stageHeight / 20);
                r4.move(stageWidth / 10, 3 * stageHeight / 20);
                f = false;
                for(Block b : blocks) {
                    if(hits(b)) {
                        f = true;
                        break;
                    }
                }
                f = f || (r1.hitsWall().x || r2.hitsWall().x || r3.hitsWall().x || r4.hitsWall().x);
                if(!f) return this;
                px--;
                r1.move(-stageWidth / 10, 0);
                r2.move(-stageWidth / 10, 0);
                r3.move(-stageWidth / 10, 0);
                r4.move(-stageWidth / 10, 0);
                f = false;
                for(Block b : blocks) {
                    if(hits(b)) {
                        f = true;
                        break;
                    }
                }
                f = f || (r1.hitsWall().x || r2.hitsWall().x || r3.hitsWall().x || r4.hitsWall().x);
                if(!f) return this;
                px++;
                py -= 2;
                r1.move(stageWidth / 10, -2 * stageHeight / 20);
                r2.move(stageWidth / 10, -2 * stageHeight / 20);
                r3.move(stageWidth / 10, -2 * stageHeight / 20);
                r4.move(stageWidth / 10, -2 * stageHeight / 20);
                rotateState = 2;
        }
        r1.moveTo(py * stageHeight / 20 - r1.getPos().y + px * stageWidth / 10, r1.getPos().x - px * stageWidth / 10 + py * stageHeight / 20);
        r3.moveTo(py * stageHeight / 20 - r3.getPos().y + px * stageWidth / 10, r3.getPos().x - px * stageWidth / 10 + py * stageHeight / 20);
        r4.moveTo(py * stageHeight / 20 - r4.getPos().y + px * stageWidth / 10, r4.getPos().x - px * stageWidth / 10 + py * stageHeight / 20);
        f = false;
        return this;
    }

    Block rotateRight() {
        if(!active) return this;
        boolean f = false;
        lockDown++;
        r1.moveTo(py * stageHeight / 20 - r1.getPos().y + px * stageWidth / 10, r1.getPos().x - px * stageWidth / 10 + py * stageHeight / 20);
        r3.moveTo(py * stageHeight / 20 - r3.getPos().y + px * stageWidth / 10, r3.getPos().x - px * stageWidth / 10 + py * stageHeight / 20);
        r4.moveTo(py * stageHeight / 20 - r4.getPos().y + px * stageWidth / 10, r4.getPos().x - px * stageWidth / 10 + py * stageHeight / 20);
        rotateState--;
        if(rotateState == -1) rotateState = 3;
        switch(rotateState) {
            case 0:
                f = false;
                for(Block b : blocks) {
                    if(hits(b)) {
                        f = true;
                        break;
                    }
                }
                f = f || (r1.hitsWall().x || r2.hitsWall().x || r3.hitsWall().x || r4.hitsWall().x);
                if(!f) return this;
                px--;
                r1.move(-stageWidth / 10, 0);
                r2.move(-stageWidth / 10, 0);
                r3.move(-stageWidth / 10, 0);
                r4.move(-stageWidth / 10, 0);
                f = false;
                for(Block b : blocks) {
                    if(hits(b)) {
                        f = true;
                        break;
                    }
                }
                f = f || (r1.hitsWall().x || r2.hitsWall().x || r3.hitsWall().x || r4.hitsWall().x);
                if(!f) return this;
                py++;
                r1.move(0, stageHeight / 20);
                r2.move(0, stageHeight / 20);
                r3.move(0, stageHeight / 20);
                r4.move(0, stageHeight / 20);
                f = false;
                for(Block b : blocks) {
                    if(hits(b)) {
                        f = true;
                        break;
                    }
                }
                f = f || (r1.hitsWall().x || r2.hitsWall().x || r3.hitsWall().x || r4.hitsWall().x);
                if(!f) return this;
                px++;
                py -= 3;
                r1.move(stageWidth / 10, -3 * stageHeight / 20);
                r2.move(stageWidth / 10, -3 * stageHeight / 20);
                r3.move(stageWidth / 10, -3 * stageHeight / 20);
                r4.move(stageWidth / 10, -3 * stageHeight / 20);
                f = false;
                for(Block b : blocks) {
                    if(hits(b)) {
                        f = true;
                        break;
                    }
                }
                f = f || (r1.hitsWall().x || r2.hitsWall().x || r3.hitsWall().x || r4.hitsWall().x);
                if(!f) return this;
                px--;
                r1.move(-stageWidth / 10, 0);
                r2.move(-stageWidth / 10, 0);
                r3.move(-stageWidth / 10, 0);
                r4.move(-stageWidth / 10, 0);
                f = false;
                for(Block b : blocks) {
                    if(hits(b)) {
                        f = true;
                        break;
                    }
                }
                f = f || (r1.hitsWall().x || r2.hitsWall().x || r3.hitsWall().x || r4.hitsWall().x);
                if(!f) return this;
                px++;
                py += 2;
                r1.move(stageWidth / 10, 2 * stageHeight / 20);
                r2.move(stageWidth / 10, 2 * stageHeight / 20);
                r3.move(stageWidth / 10, 2 * stageHeight / 20);
                r4.move(stageWidth / 10, 2 * stageHeight / 20);
                rotateState = 1;
                break;

            case 1:
                f = false;
                for(Block b : blocks) {
                    if(hits(b)) {
                        f = true;
                        break;
                    }
                }
                f = f || (r1.hitsWall().x || r2.hitsWall().x || r3.hitsWall().x || r4.hitsWall().x);
                if(!f) return this;
                px++;
                r1.move(stageWidth / 10, 0);
                r2.move(stageWidth / 10, 0);
                r3.move(stageWidth / 10, 0);
                r4.move(stageWidth / 10, 0);
                f = false;
                for(Block b : blocks) {
                    if(hits(b)) {
                        f = true;
                        break;
                    }
                }
                f = f || (r1.hitsWall().x || r2.hitsWall().x || r3.hitsWall().x || r4.hitsWall().x);
                if(!f) return this;
                py--;
                r1.move(0, -stageHeight / 20);
                r2.move(0, -stageHeight / 20);
                r3.move(0, -stageHeight / 20);
                r4.move(0, -stageHeight / 20);
                f = false;
                for(Block b : blocks) {
                    if(hits(b)) {
                        f = true;
                        break;
                    }
                }
                f = f || (r1.hitsWall().x || r2.hitsWall().x || r3.hitsWall().x || r4.hitsWall().x);
                if(!f) return this;
                px--;
                py += 3;
                r1.move(-stageWidth / 10, 3 * stageHeight / 20);
                r2.move(-stageWidth / 10, 3 * stageHeight / 20);
                r3.move(-stageWidth / 10, 3 * stageHeight / 20);
                r4.move(-stageWidth / 10, 3 * stageHeight / 20);
                f = false;
                for(Block b : blocks) {
                    if(hits(b)) {
                        f = true;
                        break;
                    }
                }
                f = f || (r1.hitsWall().x || r2.hitsWall().x || r3.hitsWall().x || r4.hitsWall().x);
                if(!f) return this;
                px++;
                r1.move(stageWidth / 10, 0);
                r2.move(stageWidth / 10, 0);
                r3.move(stageWidth / 10, 0);
                r4.move(stageWidth / 10, 0);
                f = false;
                for(Block b : blocks) {
                    if(hits(b)) {
                        f = true;
                        break;
                    }
                }
                f = f || (r1.hitsWall().x || r2.hitsWall().x || r3.hitsWall().x || r4.hitsWall().x);
                if(!f) return this;
                px--;
                py -= 2;
                r1.move(-stageWidth / 10, -2 * stageHeight / 20);
                r2.move(-stageWidth / 10, -2 * stageHeight / 20);
                r3.move(-stageWidth / 10, -2 * stageHeight / 20);
                r4.move(-stageWidth / 10, -2 * stageHeight / 20);
                rotateState = 2;
                break;
            
            case 2:
                f = false;
                for(Block b : blocks) {
                    if(hits(b)) {
                        f = true;
                        break;
                    }
                }
                f = f || (r1.hitsWall().x || r2.hitsWall().x || r3.hitsWall().x || r4.hitsWall().x);
                if(!f) return this;
                px++;
                r1.move(stageWidth / 10, 0);
                r2.move(stageWidth / 10, 0);
                r3.move(stageWidth / 10, 0);
                r4.move(stageWidth / 10, 0);
                f = false;
                for(Block b : blocks) {
                    if(hits(b)) {
                        f = true;
                        break;
                    }
                }
                f = f || (r1.hitsWall().x || r2.hitsWall().x || r3.hitsWall().x || r4.hitsWall().x);
                if(!f) return this;
                py++;
                r1.move(0, stageHeight / 20);
                r2.move(0, stageHeight / 20);
                r3.move(0, stageHeight / 20);
                r4.move(0, stageHeight / 20);
                f = false;
                for(Block b : blocks) {
                    if(hits(b)) {
                        f = true;
                        break;
                    }
                }
                f = f || (r1.hitsWall().x || r2.hitsWall().x || r3.hitsWall().x || r4.hitsWall().x);
                if(!f) return this;
                px--;
                py -= 3;
                r1.move(-stageWidth / 10, -3 * stageHeight / 20);
                r2.move(-stageWidth / 10, -3 * stageHeight / 20);
                r3.move(-stageWidth / 10, -3 * stageHeight / 20);
                r4.move(-stageWidth / 10, -3 * stageHeight / 20);
                f = false;
                for(Block b : blocks) {
                    if(hits(b)) {
                        f = true;
                        break;
                    }
                }
                f = f || (r1.hitsWall().x || r2.hitsWall().x || r3.hitsWall().x || r4.hitsWall().x);
                if(!f) return this;
                px++;
                r1.move(stageWidth / 10, 0);
                r2.move(stageWidth / 10, 0);
                r3.move(stageWidth / 10, 0);
                r4.move(stageWidth / 10, 0);
                f = false;
                for(Block b : blocks) {
                    if(hits(b)) {
                        f = true;
                        break;
                    }
                }
                f = f || (r1.hitsWall().x || r2.hitsWall().x || r3.hitsWall().x || r4.hitsWall().x);
                if(!f) return this;
                px--;
                py += 2;
                r1.move(-stageWidth / 10, 2 * stageHeight / 20);
                r2.move(-stageWidth / 10, 2 * stageHeight / 20);
                r3.move(-stageWidth / 10, 2 * stageHeight / 20);
                r4.move(-stageWidth / 10, 2 * stageHeight / 20);
                rotateState = 3;

            case 3:
                f = false;
                for(Block b : blocks) {
                    if(hits(b)) {
                        f = true;
                        break;
                    }
                }
                f = f || (r1.hitsWall().x || r2.hitsWall().x || r3.hitsWall().x || r4.hitsWall().x);
                if(!f) return this;
                px--;
                r1.move(-stageWidth / 10, 0);
                r2.move(-stageWidth / 10, 0);
                r3.move(-stageWidth / 10, 0);
                r4.move(-stageWidth / 10, 0);
                f = false;
                for(Block b : blocks) {
                    if(hits(b)) {
                        f = true;
                        break;
                    }
                }
                f = f || (r1.hitsWall().x || r2.hitsWall().x || r3.hitsWall().x || r4.hitsWall().x);
                if(!f) return this;
                py--;
                r1.move(0, -stageHeight / 20);
                r2.move(0, -stageHeight / 20);
                r3.move(0, -stageHeight / 20);
                r4.move(0, -stageHeight / 20);
                f = false;
                for(Block b : blocks) {
                    if(hits(b)) {
                        f = true;
                        break;
                    }
                }
                f = f || (r1.hitsWall().x || r2.hitsWall().x || r3.hitsWall().x || r4.hitsWall().x);
                if(!f) return this;
                px++;
                py += 3;
                r1.move(stageWidth / 10, 3 * stageHeight / 20);
                r2.move(stageWidth / 10, 3 * stageHeight / 20);
                r3.move(stageWidth / 10, 3 * stageHeight / 20);
                r4.move(stageWidth / 10, 3 * stageHeight / 20);
                f = false;
                for(Block b : blocks) {
                    if(hits(b)) {
                        f = true;
                        break;
                    }
                }
                f = f || (r1.hitsWall().x || r2.hitsWall().x || r3.hitsWall().x || r4.hitsWall().x);
                if(!f) return this;
                px--;
                r1.move(-stageWidth / 10, 0);
                r2.move(-stageWidth / 10, 0);
                r3.move(-stageWidth / 10, 0);
                r4.move(-stageWidth / 10, 0);
                f = false;
                for(Block b : blocks) {
                    if(hits(b)) {
                        f = true;
                        break;
                    }
                }
                f = f || (r1.hitsWall().x || r2.hitsWall().x || r3.hitsWall().x || r4.hitsWall().x);
                if(!f) return this;
                px++;
                py -= 2;
                r1.move(stageWidth / 10, -2 * stageHeight / 20);
                r2.move(stageWidth / 10, -2 * stageHeight / 20);
                r3.move(stageWidth / 10, -2 * stageHeight / 20);
                r4.move(stageWidth / 10, -2 * stageHeight / 20);
                rotateState = 0;
        }
        r1.moveTo(r1.getPos().y - py * stageHeight / 20 + px * stageWidth / 10, px * stageWidth / 10 - r1.getPos().x + py * stageHeight / 20);
        r3.moveTo(r3.getPos().y - py * stageHeight / 20 + px * stageWidth / 10, px * stageWidth / 10 - r3.getPos().x + py * stageHeight / 20);
        r4.moveTo(r4.getPos().y - py * stageHeight / 20 + px * stageWidth / 10, px * stageWidth / 10 - r4.getPos().x + py * stageHeight / 20);
        f = false;
        return this;
    }

    boolean isActive() {
        return active;
    }

    Block delete(int line) {
        if(r1.getPos().y == line * stageHeight / 20) v1 = false;
        if(r2.getPos().y == line * stageHeight / 20) v2 = false;
        if(r3.getPos().y == line * stageHeight / 20) v3 = false;
        if(r4.getPos().y == line * stageHeight / 20) v4 = false;
        return this;
    }

    boolean allDelete() {
        return !v1 && !v2 && !v3 && !v4;
    }

    boolean hasLine21() {
        return r1.getPos().y < 0 || r3.getPos().y < 0 || r4.getPos().y < 0;
    }

    Block setColor(color col) {
        c = col;
        r1.setColor(c);
        r2.setColor(c);
        r3.setColor(c);
        r4.setColor(c);
        return this;
    }

    boolean getSpinFlag() {
        return spinFlag;
    }
}

class BlockT extends Block {

    int vpx, vpy, count;
    Rect vr1, vr2, vr3, vr4;

    BlockT() {
        px = 4;
        py = -1;
        vpx = 4;
        vpy = -1;
        t = 0;
        count = 0;
        rotateState = 0;
        lockDown = 0;
        r1 = new Rect((px - 1) * stageWidth / 10, py * stageHeight / 20, stageWidth / 10, stageHeight / 20).setColor(MAGENTA);
        r2 = new Rect(px * stageWidth / 10, py * stageHeight / 20, stageWidth / 10, stageHeight / 20).setColor(MAGENTA);
        r3 = new Rect((px + 1) * stageWidth / 10, py * stageHeight / 20, stageWidth / 10, stageHeight / 20).setColor(MAGENTA);
        r4 = new Rect(px * stageWidth / 10, (py - 1) * stageHeight / 20, stageWidth / 10, stageHeight / 20).setColor(MAGENTA);
        vr1 = new Rect((px - 1) * stageWidth / 10, (py - 1) * stageHeight / 20, stageWidth / 10, stageHeight / 20);
        vr2 = new Rect((px + 1) * stageWidth / 10, (py - 1) * stageHeight / 20, stageWidth / 10, stageHeight / 20);
        vr3 = new Rect((px - 1) * stageWidth / 10, (py + 1) * stageHeight / 20, stageWidth / 10, stageHeight / 20);
        vr4 = new Rect((px + 1) * stageWidth / 10, (py + 1) * stageHeight / 20, stageWidth / 10, stageHeight / 20);
        v1 = true;
        v2 = true;
        v3 = true;
        v4 = true;
        active = true;
        spinFlag = false;
        c = MAGENTA;
        stop = false;
        for(Block b : blocks) {
            if(hits(b)) {
                stop = true;
                break;
            }
        }
        if(stop) active = false;
    }

    private void virtualHits(Block b) {
        Vector<Rect> br = new Vector(), vr = new Vector();
        Vector<Boolean> vbr = new Vector();
        float dx = 0.0, dy = 0.0;
        if(b.getV1()) br.add(b.getR1());
        if(b.getV2()) br.add(b.getR2());
        if(b.getV3()) br.add(b.getR3());
        if(b.getV4()) br.add(b.getR4());
        vr.add(vr1);
        vr.add(vr2);
        vr.add(vr3);
        vr.add(vr4);
        for(Rect vri : vr) {
            for(Rect bri : br) {
                dx = abs(bri.getPos().x - vri.getPos().x);
                dy = abs(bri.getPos().y - vri.getPos().y);
                if(dx < stageWidth / 20 && dy < height / 40 || vri.hitsWall().x || vri.hitsWall().y) {
                    count++;
                    break;
                }
            }
        }
    }

    private boolean update() {
        boolean f = false;
        count = 0;
        for(Block b : blocks) {
            if(hits(b)) f = true;
            virtualHits(b);
        }
        if(count >= 3) spinFlag = true;
        f = f || (r1.hitsWall().x || r2.hitsWall().x || r3.hitsWall().x || r4.hitsWall().x);
        return f;
    }

    @Override
    BlockT rotateLeft() {
        if(!active) return this;
        boolean f = false;
        lockDown++;
        if(vpx != px || vpy != py) {
            vr1.move((px - vpx) * stageWidth / 10, (py - vpy) * height / 20);
            vr2.move((px - vpx) * stageWidth / 10, (py - vpy) * height / 20);
            vr3.move((px - vpx) * stageWidth / 10, (py - vpy) * height / 20);
            vr4.move((px - vpx) * stageWidth / 10, (py - vpy) * height / 20);
            vpx = px;
            vpy = py;
        }
        r1.moveTo(r1.getPos().y - py * stageHeight / 20 + px * stageWidth / 10, px * stageWidth / 10 - r1.getPos().x + py * stageHeight / 20);
        r3.moveTo(r3.getPos().y - py * stageHeight / 20 + px * stageWidth / 10, px * stageWidth / 10 - r3.getPos().x + py * stageHeight / 20);
        r4.moveTo(r4.getPos().y - py * stageHeight / 20 + px * stageWidth / 10, px * stageWidth / 10 - r4.getPos().x + py * stageHeight / 20);
        vr1.moveTo(vr1.getPos().y - py * stageHeight / 20 + px * stageWidth / 10, px * stageWidth / 10 - vr1.getPos().x + py * stageHeight / 20);
        vr2.moveTo(vr2.getPos().y - py * stageHeight / 20 + px * stageWidth / 10, px * stageWidth / 10 - vr2.getPos().x + py * stageHeight / 20);
        vr3.moveTo(vr3.getPos().y - py * stageHeight / 20 + px * stageWidth / 10, px * stageWidth / 10 - vr3.getPos().x + py * stageHeight / 20);
        vr4.moveTo(vr4.getPos().y - py * stageHeight / 20 + px * stageWidth / 10, px * stageWidth / 10 - vr4.getPos().x + py * stageHeight / 20);
        rotateState++;
        if(rotateState == 4) rotateState = 0;
        switch(rotateState) {
            case 0:
                f = update();
                if(!f) return this;
                
                px++;
                r1.move(stageWidth / 10, 0);
                r2.move(stageWidth / 10, 0);
                r3.move(stageWidth / 10, 0);
                r4.move(stageWidth / 10, 0);
                vpx++;
                vr1.move(stageWidth / 10, 0);
                vr2.move(stageWidth / 10, 0);
                vr3.move(stageWidth / 10, 0);
                vr4.move(stageWidth / 10, 0);

                f = update();
                if(!f) return this;
                
                py++;
                r1.move(0, stageHeight / 20);
                r2.move(0, stageHeight / 20);
                r3.move(0, stageHeight / 20);
                r4.move(0, stageHeight / 20);
                vpy++;
                vr1.move(0, stageHeight / 20);
                vr2.move(0, stageHeight / 20);
                vr3.move(0, stageHeight / 20);
                vr4.move(0, stageHeight / 20);

                f = update();
                if(!f) return this;
                
                px--;
                py -= 3;
                r1.move(-stageWidth / 10, -3 * stageHeight / 20);
                r2.move(-stageWidth / 10, -3 * stageHeight / 20);
                r3.move(-stageWidth / 10, -3 * stageHeight / 20);
                r4.move(-stageWidth / 10, -3 * stageHeight / 20);
                vpx--;
                vpy -= 3;
                vr1.move(-stageWidth / 10, -3 * stageHeight / 20);
                vr2.move(-stageWidth / 10, -3 * stageHeight / 20);
                vr3.move(-stageWidth / 10, -3 * stageHeight / 20);
                vr4.move(-stageWidth / 10, -3 * stageHeight / 20);
                
                f = update();
                if(!f) return this;
                
                px++;
                r1.move(stageWidth / 10, 0);
                r2.move(stageWidth / 10, 0);
                r3.move(stageWidth / 10, 0);
                r4.move(stageWidth / 10, 0);
                vpx++;
                vr1.move(stageWidth / 10, 0);
                vr2.move(stageWidth / 10, 0);
                vr3.move(stageWidth / 10, 0);
                vr4.move(stageWidth / 10, 0);

                f = update();
                if(!f) return this;
                
                px--;
                py += 2;
                r1.move(-stageWidth / 10, 2 * stageHeight / 20);
                r2.move(-stageWidth / 10, 2 * stageHeight / 20);
                r3.move(-stageWidth / 10, 2 * stageHeight / 20);
                r4.move(-stageWidth / 10, 2 * stageHeight / 20);
                vpx--;
                vpy += 2;
                vr1.move(-stageWidth / 10, 2 * stageHeight / 20);
                vr2.move(-stageWidth / 10, 2 * stageHeight / 20);
                vr3.move(-stageWidth / 10, 2 * stageHeight / 20);
                vr4.move(-stageWidth / 10, 2 * stageHeight / 20);
                rotateState = 3;
                break;

            case 1:
                f = update();
                if(!f) return this;
                
                px++;
                r1.move(stageWidth / 10, 0);
                r2.move(stageWidth / 10, 0);
                r3.move(stageWidth / 10, 0);
                r4.move(stageWidth / 10, 0);
                vpx++;
                vr1.move(stageWidth / 10, 0);
                vr2.move(stageWidth / 10, 0);
                vr3.move(stageWidth / 10, 0);
                vr4.move(stageWidth / 10, 0);
                
                f = update();
                if(!f) return this;
                
                py--;
                r1.move(0, -stageHeight / 20);
                r2.move(0, -stageHeight / 20);
                r3.move(0, -stageHeight / 20);
                r4.move(0, -stageHeight / 20);
                vpy--;
                vr1.move(0, -stageHeight / 20);
                vr2.move(0, -stageHeight / 20);
                vr3.move(0, -stageHeight / 20);
                vr4.move(0, -stageHeight / 20);
                
                f = update();
                if(!f) return this;
                
                px--;
                py += 3;
                r1.move(-stageWidth / 10, 3 * stageHeight / 20);
                r2.move(-stageWidth / 10, 3 * stageHeight / 20);
                r3.move(-stageWidth / 10, 3 * stageHeight / 20);
                r4.move(-stageWidth / 10, 3 * stageHeight / 20);
                vpx--;
                vpy += 3;
                vr1.move(-stageWidth / 10, 3 * stageHeight / 20);
                vr2.move(-stageWidth / 10, 3 * stageHeight / 20);
                vr3.move(-stageWidth / 10, 3 * stageHeight / 20);
                vr4.move(-stageWidth / 10, 3 * stageHeight / 20);

                f = update();
                if(!f) return this;
                
                px++;
                r1.move(stageWidth / 10, 0);
                r2.move(stageWidth / 10, 0);
                r3.move(stageWidth / 10, 0);
                r4.move(stageWidth / 10, 0);
                vpx++;
                vr1.move(stageWidth / 10, 0);
                vr2.move(stageWidth / 10, 0);
                vr3.move(stageWidth / 10, 0);
                vr4.move(stageWidth / 10, 0);
                
                f = update();
                if(!f) return this;
            
                px--;
                py -= 2;
                r1.move(-stageWidth / 10, -2 * stageHeight / 20);
                r2.move(-stageWidth / 10, -2 * stageHeight / 20);
                r3.move(-stageWidth / 10, -2 * stageHeight / 20);
                r4.move(-stageWidth / 10, -2 * stageHeight / 20);
                vpx--;
                vpy -= 2;
                vr1.move(-stageWidth / 10, -2 * stageHeight / 20);
                vr2.move(-stageWidth / 10, -2 * stageHeight / 20);
                vr3.move(-stageWidth / 10, -2 * stageHeight / 20);
                vr4.move(-stageWidth / 10, -2 * stageHeight / 20);
                rotateState = 0;
                break;

            case 2:
                f = update();
                if(!f) return this;
                
                px--;
                r1.move(-stageWidth / 10, 0);
                r2.move(-stageWidth / 10, 0);
                r3.move(-stageWidth / 10, 0);
                r4.move(-stageWidth / 10, 0);
                vpx--;
                vr1.move(-stageWidth / 10, 0);
                vr2.move(-stageWidth / 10, 0);
                vr3.move(-stageWidth / 10, 0);
                vr4.move(-stageWidth / 10, 0);
                
                f = update();
                if(!f) return this;
                
                py++;
                r1.move(0, stageHeight / 20);
                r2.move(0, stageHeight / 20);
                r3.move(0, stageHeight / 20);
                r4.move(0, stageHeight / 20);
                vpy++;
                vr1.move(0, stageHeight / 20);
                vr2.move(0, stageHeight / 20);
                vr3.move(0, stageHeight / 20);
                vr4.move(0, stageHeight / 20);

                f = update();
                if(!f) return this;
                
                px++;
                py -= 3;
                r1.move(stageWidth / 10, -3 * stageHeight / 20);
                r2.move(stageWidth / 10, -3 * stageHeight / 20);
                r3.move(stageWidth / 10, -3 * stageHeight / 20);
                r4.move(stageWidth / 10, -3 * stageHeight / 20);
                vpx++;
                vpy -= 3;
                vr1.move(stageWidth / 10, -3 * stageHeight / 20);
                vr2.move(stageWidth / 10, -3 * stageHeight / 20);
                vr3.move(stageWidth / 10, -3 * stageHeight / 20);
                vr4.move(stageWidth / 10, -3 * stageHeight / 20);
                
                f = update();
                if(!f) return this;
                
                px--;
                r1.move(-stageWidth / 10, 0);
                r2.move(-stageWidth / 10, 0);
                r3.move(-stageWidth / 10, 0);
                r4.move(-stageWidth / 10, 0);
                vpx--;
                vr1.move(-stageWidth / 10, 0);
                vr2.move(-stageWidth / 10, 0);
                vr3.move(-stageWidth / 10, 0);
                vr4.move(-stageWidth / 10, 0);

                f = update();
                if(!f) return this;
                
                px++;
                py += 2;
                r1.move(stageWidth / 10, 2 * stageHeight / 20);
                r2.move(stageWidth / 10, 2 * stageHeight / 20);
                r3.move(stageWidth / 10, 2 * stageHeight / 20);
                r4.move(stageWidth / 10, 2 * stageHeight / 20);
                vpx++;
                vpy += 2;
                vr1.move(stageWidth / 10, 2 * stageHeight / 20);
                vr2.move(stageWidth / 10, 2 * stageHeight / 20);
                vr3.move(stageWidth / 10, 2 * stageHeight / 20);
                vr4.move(stageWidth / 10, 2 * stageHeight / 20);
                rotateState = 1;
                break;

            case 3:
                f = update();
                if(!f) return this;
                
                px--;
                r1.move(-stageWidth / 10, 0);
                r2.move(-stageWidth / 10, 0);
                r3.move(-stageWidth / 10, 0);
                r4.move(-stageWidth / 10, 0);
                vpx--;
                vr1.move(-stageWidth / 10, 0);
                vr2.move(-stageWidth / 10, 0);
                vr3.move(-stageWidth / 10, 0);
                vr4.move(-stageWidth / 10, 0);
                
                f = update();
                if(!f) return this;
                
                py--;
                r1.move(0, -stageHeight / 20);
                r2.move(0, -stageHeight / 20);
                r3.move(0, -stageHeight / 20);
                r4.move(0, -stageHeight / 20);
                vpy--;
                vr1.move(0, -stageHeight / 20);
                vr2.move(0, -stageHeight / 20);
                vr3.move(0, -stageHeight / 20);
                vr4.move(0, -stageHeight / 20);
                
                f = update();
                if(!f) return this;
                
                px++;
                py += 3;
                r1.move(stageWidth / 10, 3 * stageHeight / 20);
                r2.move(stageWidth / 10, 3 * stageHeight / 20);
                r3.move(stageWidth / 10, 3 * stageHeight / 20);
                r4.move(stageWidth / 10, 3 * stageHeight / 20);
                vpx++;
                vpy += 3;
                vr1.move(stageWidth / 10, 3 * stageHeight / 20);
                vr2.move(stageWidth / 10, 3 * stageHeight / 20);
                vr3.move(stageWidth / 10, 3 * stageHeight / 20);
                vr4.move(stageWidth / 10, 3 * stageHeight / 20);
                
                f = update();
                if(!f) return this;
                
                px--;
                r1.move(-stageWidth / 10, 0);
                r2.move(-stageWidth / 10, 0);
                r3.move(-stageWidth / 10, 0);
                r4.move(-stageWidth / 10, 0);
                vpx--;
                vr1.move(-stageWidth / 10, 0);
                vr2.move(-stageWidth / 10, 0);
                vr3.move(-stageWidth / 10, 0);
                vr4.move(-stageWidth / 10, 0);
                
                f = update();
                if(!f) return this;
                
                px++;
                py -= 2;
                r1.move(stageWidth / 10, -2 * stageHeight / 20);
                r2.move(stageWidth / 10, -2 * stageHeight / 20);
                r3.move(stageWidth / 10, -2 * stageHeight / 20);
                r4.move(stageWidth / 10, -2 * stageHeight / 20);
                vpx++;
                vpy -= 2;
                vr1.move(stageWidth / 10, -2 * stageHeight / 20);
                vr2.move(stageWidth / 10, -2 * stageHeight / 20);
                vr3.move(stageWidth / 10, -2 * stageHeight / 20);
                vr4.move(stageWidth / 10, -2 * stageHeight / 20);
                rotateState = 2;
        }
        r1.moveTo(py * stageHeight / 20 - r1.getPos().y + px * stageWidth / 10, r1.getPos().x - px * stageWidth / 10 + py * stageHeight / 20);
        r3.moveTo(py * stageHeight / 20 - r3.getPos().y + px * stageWidth / 10, r3.getPos().x - px * stageWidth / 10 + py * stageHeight / 20);
        r4.moveTo(py * stageHeight / 20 - r4.getPos().y + px * stageWidth / 10, r4.getPos().x - px * stageWidth / 10 + py * stageHeight / 20);
        vr1.moveTo(py * stageHeight / 20 - vr1.getPos().y + px * stageWidth / 10, vr1.getPos().x - px * stageWidth / 10 + py * stageHeight / 20);
        vr2.moveTo(py * stageHeight / 20 - vr2.getPos().y + px * stageWidth / 10, vr2.getPos().x - px * stageWidth / 10 + py * stageHeight / 20);
        vr3.moveTo(py * stageHeight / 20 - vr3.getPos().y + px * stageWidth / 10, vr3.getPos().x - px * stageWidth / 10 + py * stageHeight / 20);
        vr4.moveTo(py * stageHeight / 20 - vr4.getPos().y + px * stageWidth / 10, vr4.getPos().x - px * stageWidth / 10 + py * stageHeight / 20);
        f = false;
        spinFlag = false;
        return this;
    }

    @Override
    BlockT rotateRight() {
        if(!active) return this;
        boolean f = false;
        lockDown++;
        if(vpx != px || vpy != py) {
            vr1.move((px - vpx) * stageWidth / 10, (py - vpy) * height / 20);
            vr2.move((px - vpx) * stageWidth / 10, (py - vpy) * height / 20);
            vr3.move((px - vpx) * stageWidth / 10, (py - vpy) * height / 20);
            vr4.move((px - vpx) * stageWidth / 10, (py - vpy) * height / 20);
            vpx = px;
            vpy = py;
        }
        r1.moveTo(py * stageHeight / 20 - r1.getPos().y + px * stageWidth / 10, r1.getPos().x - px * stageWidth / 10 + py * stageHeight / 20);
        r3.moveTo(py * stageHeight / 20 - r3.getPos().y + px * stageWidth / 10, r3.getPos().x - px * stageWidth / 10 + py * stageHeight / 20);
        r4.moveTo(py * stageHeight / 20 - r4.getPos().y + px * stageWidth / 10, r4.getPos().x - px * stageWidth / 10 + py * stageHeight / 20);
        vr1.moveTo(py * stageHeight / 20 - vr1.getPos().y + px * stageWidth / 10, vr1.getPos().x - px * stageWidth / 10 + py * stageHeight / 20);
        vr2.moveTo(py * stageHeight / 20 - vr2.getPos().y + px * stageWidth / 10, vr2.getPos().x - px * stageWidth / 10 + py * stageHeight / 20);
        vr3.moveTo(py * stageHeight / 20 - vr3.getPos().y + px * stageWidth / 10, vr3.getPos().x - px * stageWidth / 10 + py * stageHeight / 20);
        vr4.moveTo(py * stageHeight / 20 - vr4.getPos().y + px * stageWidth / 10, vr4.getPos().x - px * stageWidth / 10 + py * stageHeight / 20);
        rotateState--;
        if(rotateState == -1) rotateState = 3;
        switch(rotateState) {
            case 0:
                f = update();
                if(!f) return this;
                
                px--;
                r1.move(-stageWidth / 10, 0);
                r2.move(-stageWidth / 10, 0);
                r3.move(-stageWidth / 10, 0);
                r4.move(-stageWidth / 10, 0);
                vpx--;
                vr1.move(-stageWidth / 10, 0);
                vr2.move(-stageWidth / 10, 0);
                vr3.move(-stageWidth / 10, 0);
                vr4.move(-stageWidth / 10, 0);
                
                f = update();
                if(!f) return this;
                
                py++;
                r1.move(0, stageHeight / 20);
                r2.move(0, stageHeight / 20);
                r3.move(0, stageHeight / 20);
                r4.move(0, stageHeight / 20);
                vpy++;
                vr1.move(0, stageHeight / 20);
                vr2.move(0, stageHeight / 20);
                vr3.move(0, stageHeight / 20);
                vr4.move(0, stageHeight / 20);
                
                f = update();
                if(!f) return this;
                
                px++;
                py -= 3;
                r1.move(stageWidth / 10, -3 * stageHeight / 20);
                r2.move(stageWidth / 10, -3 * stageHeight / 20);
                r3.move(stageWidth / 10, -3 * stageHeight / 20);
                r4.move(stageWidth / 10, -3 * stageHeight / 20);
                vpx++;
                vpy -= 3;
                vr1.move(stageWidth / 10, -3 * stageHeight / 20);
                vr2.move(stageWidth / 10, -3 * stageHeight / 20);
                vr3.move(stageWidth / 10, -3 * stageHeight / 20);
                vr4.move(stageWidth / 10, -3 * stageHeight / 20);
                
                f = update();
                if(!f) return this;
                
                px--;
                r1.move(-stageWidth / 10, 0);
                r2.move(-stageWidth / 10, 0);
                r3.move(-stageWidth / 10, 0);
                r4.move(-stageWidth / 10, 0);
                vpx--;
                vr1.move(-stageWidth / 10, 0);
                vr2.move(-stageWidth / 10, 0);
                vr3.move(-stageWidth / 10, 0);
                vr4.move(-stageWidth / 10, 0);
                
                f = update();
                if(!f) return this;
                
                px++;
                py += 2;
                r1.move(stageWidth / 10, 2 * stageHeight / 20);
                r2.move(stageWidth / 10, 2 * stageHeight / 20);
                r3.move(stageWidth / 10, 2 * stageHeight / 20);
                r4.move(stageWidth / 10, 2 * stageHeight / 20);
                vpx++;
                vpy += 2;
                vr1.move(stageWidth / 10, 2 * stageHeight / 20);
                vr2.move(stageWidth / 10, 2 * stageHeight / 20);
                vr3.move(stageWidth / 10, 2 * stageHeight / 20);
                vr4.move(stageWidth / 10, 2 * stageHeight / 20);
                rotateState = 1;
                break;

            case 1:
                f = update();
                if(!f) return this;
                
                px++;
                r1.move(stageWidth / 10, 0);
                r2.move(stageWidth / 10, 0);
                r3.move(stageWidth / 10, 0);
                r4.move(stageWidth / 10, 0);
                vpx++;
                vr1.move(stageWidth / 10, 0);
                vr2.move(stageWidth / 10, 0);
                vr3.move(stageWidth / 10, 0);
                vr4.move(stageWidth / 10, 0);
                
                f = update();
                if(!f) return this;
                
                py--;
                r1.move(0, -stageHeight / 20);
                r2.move(0, -stageHeight / 20);
                r3.move(0, -stageHeight / 20);
                r4.move(0, -stageHeight / 20);
                vpy--;
                vr1.move(0, -stageHeight / 20);
                vr2.move(0, -stageHeight / 20);
                vr3.move(0, -stageHeight / 20);
                vr4.move(0, -stageHeight / 20);
                
                f = update();
                if(!f) return this;
                
                px--;
                py += 3;
                r1.move(-stageWidth / 10, 3 * stageHeight / 20);
                r2.move(-stageWidth / 10, 3 * stageHeight / 20);
                r3.move(-stageWidth / 10, 3 * stageHeight / 20);
                r4.move(-stageWidth / 10, 3 * stageHeight / 20);
                vpx--;
                vpy += 3;
                vr1.move(-stageWidth / 10, 3 * stageHeight / 20);
                vr2.move(-stageWidth / 10, 3 * stageHeight / 20);
                vr3.move(-stageWidth / 10, 3 * stageHeight / 20);
                vr4.move(-stageWidth / 10, 3 * stageHeight / 20);
                
                f = update();
                if(!f) return this;
            
                px++;
                r1.move(stageWidth / 10, 0);
                r2.move(stageWidth / 10, 0);
                r3.move(stageWidth / 10, 0);
                r4.move(stageWidth / 10, 0);
                vpx++;
                vr1.move(stageWidth / 10, 0);
                vr2.move(stageWidth / 10, 0);
                vr3.move(stageWidth / 10, 0);
                vr4.move(stageWidth / 10, 0);
                
                f = update();
                if(!f) return this;

                px--;
                py -= 2;
                r1.move(-stageWidth / 10, -2 * stageHeight / 20);
                r2.move(-stageWidth / 10, -2 * stageHeight / 20);
                r3.move(-stageWidth / 10, -2 * stageHeight / 20);
                r4.move(-stageWidth / 10, -2 * stageHeight / 20);
                vpx--;
                vpy -= 2;
                vr1.move(-stageWidth / 10, -2 * stageHeight / 20);
                vr2.move(-stageWidth / 10, -2 * stageHeight / 20);
                vr3.move(-stageWidth / 10, -2 * stageHeight / 20);
                vr4.move(-stageWidth / 10, -2 * stageHeight / 20);
                rotateState = 2;
                break;
            
            case 2:
                f = update();
                if(!f) return this;

                px++;
                r1.move(stageWidth / 10, 0);
                r2.move(stageWidth / 10, 0);
                r3.move(stageWidth / 10, 0);
                r4.move(stageWidth / 10, 0);
                vpx++;
                vr1.move(stageWidth / 10, 0);
                vr2.move(stageWidth / 10, 0);
                vr3.move(stageWidth / 10, 0);
                vr4.move(stageWidth / 10, 0);
                
                f = update();
                if(!f) return this;
        
                py++;
                r1.move(0, stageHeight / 20);
                r2.move(0, stageHeight / 20);
                r3.move(0, stageHeight / 20);
                r4.move(0, stageHeight / 20);
                vpy++;
                vr1.move(0, stageHeight / 20);
                vr2.move(0, stageHeight / 20);
                vr3.move(0, stageHeight / 20);
                vr4.move(0, stageHeight / 20);
                
                f = update();
                if(!f) return this;

                px--;
                py -= 3;
                r1.move(-stageWidth / 10, -3 * stageHeight / 20);
                r2.move(-stageWidth / 10, -3 * stageHeight / 20);
                r3.move(-stageWidth / 10, -3 * stageHeight / 20);
                r4.move(-stageWidth / 10, -3 * stageHeight / 20);
                vpx--;
                vpy -= 3;
                vr1.move(-stageWidth / 10, -3 * stageHeight / 20);
                vr2.move(-stageWidth / 10, -3 * stageHeight / 20);
                vr3.move(-stageWidth / 10, -3 * stageHeight / 20);
                vr4.move(-stageWidth / 10, -3 * stageHeight / 20);
                
                f = update();
                if(!f) return this;

                px++;
                r1.move(stageWidth / 10, 0);
                r2.move(stageWidth / 10, 0);
                r3.move(stageWidth / 10, 0);
                r4.move(stageWidth / 10, 0);
                vpx++;
                vr1.move(stageWidth / 10, 0);
                vr2.move(stageWidth / 10, 0);
                vr3.move(stageWidth / 10, 0);
                vr4.move(stageWidth / 10, 0);
                
                f = update();
                if(!f) return this;

                px--;
                py += 2;
                r1.move(-stageWidth / 10, 2 * stageHeight / 20);
                r2.move(-stageWidth / 10, 2 * stageHeight / 20);
                r3.move(-stageWidth / 10, 2 * stageHeight / 20);
                r4.move(-stageWidth / 10, 2 * stageHeight / 20);
                vpx--;
                vpy += 2;
                vr1.move(-stageWidth / 10, 2 * stageHeight / 20);
                vr2.move(-stageWidth / 10, 2 * stageHeight / 20);
                vr3.move(-stageWidth / 10, 2 * stageHeight / 20);
                vr4.move(-stageWidth / 10, 2 * stageHeight / 20);
                rotateState = 3;

            case 3:
                f = update();
                if(!f) return this;

                px--;
                r1.move(-stageWidth / 10, 0);
                r2.move(-stageWidth / 10, 0);
                r3.move(-stageWidth / 10, 0);
                r4.move(-stageWidth / 10, 0);
                vpx--;
                vr1.move(-stageWidth / 10, 0);
                vr2.move(-stageWidth / 10, 0);
                vr3.move(-stageWidth / 10, 0);
                vr4.move(-stageWidth / 10, 0);
                
                f = update();
                if(!f) return this;

                py--;
                r1.move(0, -stageHeight / 20);
                r2.move(0, -stageHeight / 20);
                r3.move(0, -stageHeight / 20);
                r4.move(0, -stageHeight / 20);
                vpy--;
                vr1.move(0, -stageHeight / 20);
                vr2.move(0, -stageHeight / 20);
                vr3.move(0, -stageHeight / 20);
                vr4.move(0, -stageHeight / 20);
                
                f = update();
                if(!f) return this;

                px++;
                py += 3;
                r1.move(stageWidth / 10, 3 * stageHeight / 20);
                r2.move(stageWidth / 10, 3 * stageHeight / 20);
                r3.move(stageWidth / 10, 3 * stageHeight / 20);
                r4.move(stageWidth / 10, 3 * stageHeight / 20);
                vpx++;
                vpy += 3;
                vr1.move(stageWidth / 10, 3 * stageHeight / 20);
                vr2.move(stageWidth / 10, 3 * stageHeight / 20);
                vr3.move(stageWidth / 10, 3 * stageHeight / 20);
                vr4.move(stageWidth / 10, 3 * stageHeight / 20);
                
                f = update();
                if(!f) return this;

                px--;
                r1.move(-stageWidth / 10, 0);
                r2.move(-stageWidth / 10, 0);
                r3.move(-stageWidth / 10, 0);
                r4.move(-stageWidth / 10, 0);
                vpx--;
                vr1.move(-stageWidth / 10, 0);
                vr2.move(-stageWidth / 10, 0);
                vr3.move(-stageWidth / 10, 0);
                vr4.move(-stageWidth / 10, 0);
                
                f = update();
                if(!f) return this;

                px++;
                py -= 2;
                r1.move(stageWidth / 10, -2 * stageHeight / 20);
                r2.move(stageWidth / 10, -2 * stageHeight / 20);
                r3.move(stageWidth / 10, -2 * stageHeight / 20);
                r4.move(stageWidth / 10, -2 * stageHeight / 20);
                vpx++;
                vpy -= 2;
                vr1.move(stageWidth / 10, -2 * stageHeight / 20);
                vr2.move(stageWidth / 10, -2 * stageHeight / 20);
                vr3.move(stageWidth / 10, -2 * stageHeight / 20);
                vr4.move(stageWidth / 10, -2 * stageHeight / 20);
                rotateState = 0;
        }
        r1.moveTo(r1.getPos().y - py * stageHeight / 20 + px * stageWidth / 10, px * stageWidth / 10 - r1.getPos().x + py * stageHeight / 20);
        r3.moveTo(r3.getPos().y - py * stageHeight / 20 + px * stageWidth / 10, px * stageWidth / 10 - r3.getPos().x + py * stageHeight / 20);
        r4.moveTo(r4.getPos().y - py * stageHeight / 20 + px * stageWidth / 10, px * stageWidth / 10 - r4.getPos().x + py * stageHeight / 20);
        vr1.moveTo(vr1.getPos().y - py * stageHeight / 20 + px * stageWidth / 10, px * stageWidth / 10 - vr1.getPos().x + py * stageHeight / 20);
        vr1.moveTo(vr2.getPos().y - py * stageHeight / 20 + px * stageWidth / 10, px * stageWidth / 10 - vr2.getPos().x + py * stageHeight / 20);
        vr3.moveTo(vr3.getPos().y - py * stageHeight / 20 + px * stageWidth / 10, px * stageWidth / 10 - vr3.getPos().x + py * stageHeight / 20);
        vr4.moveTo(vr4.getPos().y - py * stageHeight / 20 + px * stageWidth / 10, px * stageWidth / 10 - vr4.getPos().x + py * stageHeight / 20);
        f = false;
        spinFlag = false;
        return this;
    }
}

class BlockS extends Block {

    BlockS() {
        px = 4;
        py = -1;
        t = 0;
        rotateState = 0;
        r1 = new Rect((px - 1) * stageWidth / 10, py * stageHeight / 20, stageWidth / 10, stageHeight / 20).setColor(GREEN);
        r2 = new Rect(px * stageWidth / 10, py * stageHeight / 20, stageWidth / 10, stageHeight / 20).setColor(GREEN);
        r3 = new Rect(px * stageWidth / 10, (py - 1) * stageHeight / 20, stageWidth / 10, stageHeight / 20).setColor(GREEN);
        r4 = new Rect((px + 1) * stageWidth / 10, (py - 1) * stageHeight / 20, stageWidth / 10, stageHeight / 20).setColor(GREEN);
        active = true;
        v1 = true;
        v2 = true;
        v3 = true;
        v4 = true;
        spinFlag = false;
        c = GREEN;
        stop = false;
        for(Block b : blocks) {
            if(hits(b)) {
                stop = true;
                break;
            }
        }
        if(stop) active = false;
    }
}

class BlockZ extends Block {

    BlockZ() {
        px = 4;
        py = -1;
        t = 0;
        rotateState = 0;
        lockDown = 0;
        r1 = new Rect((px + 1) * stageWidth / 10, py * stageHeight / 20, stageWidth / 10, stageHeight / 20).setColor(RED);
        r2 = new Rect(px * stageWidth / 10, py * stageHeight / 20, stageWidth / 10, stageHeight / 20).setColor(RED);
        r3 = new Rect(px * stageWidth / 10, (py - 1) * stageHeight / 20, stageWidth / 10, stageHeight / 20).setColor(RED);
        r4 = new Rect((px - 1) * stageWidth / 10, (py - 1) * stageHeight / 20, stageWidth / 10, stageHeight / 20).setColor(RED);
        active = true;
        v1 = true;
        v2 = true;
        v3 = true;
        v4 = true;
        spinFlag = false;
        c = RED;
        stop = false;
        for(Block b : blocks) {
            if(hits(b)) {
                stop = true;
                break;
            }
        }
        if(stop) active = false;
    }
}

class BlockJ extends Block {

    BlockJ() {
        px = 4;
        py = -1;
        t = 0;
        rotateState = 0;
        lockDown = 0;
        r1 = new Rect((px + 1) * stageWidth / 10, py * stageHeight / 20, stageWidth / 10, stageHeight / 20).setColor(BLUE);
        r2 = new Rect(px * stageWidth / 10, py * stageHeight / 20, stageWidth / 10, stageHeight / 20).setColor(BLUE);
        r3 = new Rect((px - 1) * stageWidth / 10, py * stageHeight / 20, stageWidth / 10, stageHeight / 20).setColor(BLUE);
        r4 = new Rect((px - 1) * stageWidth / 10, (py - 1) * stageHeight / 20, stageWidth / 10, stageHeight / 20).setColor(BLUE);
        active = true;
        v1 = true;
        v2 = true;
        v3 = true;
        v4 = true;
        spinFlag = false;
        c = BLUE;
        stop = false;
        for(Block b : blocks) {
            if(hits(b)) {
                stop = true;
                break;
            }
        }
        if(stop) active = false;
    }
}

class BlockL extends Block {

    BlockL() {
        px = 4;
        py = -1;
        t = 0;
        rotateState = 0;
        lockDown = 0;
        r1 = new Rect((px - 1) * stageWidth / 10, py * stageHeight / 20, stageWidth / 10, stageHeight / 20).setColor(color(255, 165, 0));
        r2 = new Rect(px * stageWidth / 10, py * stageHeight / 20, stageWidth / 10, stageHeight / 20).setColor(color(255, 165, 0));
        r3 = new Rect((px + 1) * stageWidth / 10, py * stageHeight / 20, stageWidth / 10, stageHeight / 20).setColor(color(255, 165, 0));
        r4 = new Rect((px + 1) * stageWidth / 10, (py - 1) * stageHeight / 20, stageWidth / 10, stageHeight / 20).setColor(color(255, 165, 0));
        active = true;
        v1 = true;
        v2 = true;
        v3 = true;
        v4 = true;
        spinFlag = false;
        c = color(255, 165, 0);
        stop = false;
        for(Block b : blocks) {
            if(hits(b)) {
                stop = true;
                break;
            }
        }
        if(stop) active = false;
    }
}

class BlockI extends Block {

    BlockI() {
        px = 4;
        py = -1;
        t = 0;
        rotateState = 0;
        lockDown = 0;
        r1 = new Rect((px - 1) * stageWidth / 10, py * stageHeight / 20, stageWidth / 10, stageHeight / 20).setColor(color(0, 191, 255));
        r2 = new Rect(px * stageWidth / 10, py * stageHeight / 20, stageWidth / 10, stageHeight / 20).setColor(color(0, 191, 255));
        r3 = new Rect((px + 1) * stageWidth / 10, py * stageHeight / 20, stageWidth / 10, stageHeight / 20).setColor(color(0, 191, 255));
        r4 = new Rect((px + 2) * stageWidth / 10, py * stageHeight / 20, stageWidth / 10, stageHeight / 20).setColor(color(0, 191, 255));
        active = true;
        v1 = true;
        v2 = true;
        v3 = true;
        v4 = true;
        spinFlag = false;
        c = color(0, 191, 255);
        stop = false;
        for(Block b : blocks) {
            if(hits(b)) {
                stop = true;
                break;
            }
        }
        if(stop) active = false;
    }

    @Override
    BlockI rotateLeft() {
        if(!active) return this;
        boolean f = false;
        lockDown++;
        r1.moveTo(r1.getPos().y - py * stageHeight / 20 + px * stageWidth / 10, px * stageWidth / 10 - r1.getPos().x + py * stageHeight / 20);
        r3.moveTo(r3.getPos().y - py * stageHeight / 20 + px * stageWidth / 10, px * stageWidth / 10 - r3.getPos().x + py * stageHeight / 20);
        r4.moveTo(r4.getPos().y - py * stageHeight / 20 + px * stageWidth / 10, px * stageWidth / 10 - r4.getPos().x + py * stageHeight / 20);
        rotateState++;
        if(rotateState == 4) rotateState = 0;
        switch(rotateState) {
            case 0:
                px--;
                r1.move(-stageWidth / 10, 0);
                r2.move(-stageWidth / 10, 0);
                r3.move(-stageWidth / 10, 0);
                r4.move(-stageWidth / 10, 0);
                f = false;
                for(Block b : blocks) {
                    if(hits(b)) {
                        f = true;
                        break;
                    }
                }
                f = f || (r1.hitsWall().x || r2.hitsWall().x || r3.hitsWall().x || r4.hitsWall().x);
                if(!f) return this;
                px += 2;
                r1.move(2 * stageWidth / 10, 0);
                r2.move(2 * stageWidth / 10, 0);
                r3.move(2 * stageWidth / 10, 0);
                r4.move(2 * stageWidth / 10, 0);
                f = false;
                for(Block b : blocks) {
                    if(hits(b)) {
                        f = true;
                        break;
                    }
                }
                f = f || (r1.hitsWall().x || r2.hitsWall().x || r3.hitsWall().x || r4.hitsWall().x);
                if(!f) return this;
                px -= 3;
                r1.move(-3 * stageWidth / 10, 0);
                r2.move(-3 * stageWidth / 10, 0);
                r3.move(-3 * stageWidth / 10, 0);
                r4.move(-3 * stageWidth / 10, 0);
                f = false;
                for(Block b : blocks) {
                    if(hits(b)) {
                        f = true;
                        break;
                    }
                }
                f = f || (r1.hitsWall().x || r2.hitsWall().x || r3.hitsWall().x || r4.hitsWall().x);
                if(!f) return this;
                px += 3;
                py--;
                r1.move(3 * stageWidth / 10, -stageHeight / 20);
                r2.move(3 * stageWidth / 10, -stageHeight / 20);
                r3.move(3 * stageWidth / 10, -stageHeight / 20);
                r4.move(3 * stageWidth / 10, -stageHeight / 20);
                f = false;
                for(Block b : blocks) {
                    if(hits(b)) {
                        f = true;
                        break;
                    }
                }
                f = f || (r1.hitsWall().x || r2.hitsWall().x || r3.hitsWall().x || r4.hitsWall().x);
                if(!f) return this;
                px -= 3;
                py += 3;
                r1.move(-3 * stageWidth / 10, 3 * stageHeight / 20);
                r2.move(-3 * stageWidth / 10, 3 * stageHeight / 20);
                r3.move(-3 * stageWidth / 10, 3 * stageHeight / 20);
                r4.move(-3 * stageWidth / 10, 3 * stageHeight / 20);
                f = false;
                for(Block b : blocks) {
                    if(hits(b)) {
                        f = true;
                        break;
                    }
                }
                f = f || (r1.hitsWall().x || r2.hitsWall().x || r3.hitsWall().x || r4.hitsWall().x);
                if(!f) return this;
                px += 2;
                py -= 2;
                r1.move(2 * stageWidth / 10, -2 * stageHeight / 20);
                r2.move(2 * stageWidth / 10, -2 * stageHeight / 20);
                r3.move(2 * stageWidth / 10, -2 * stageHeight / 20);
                r4.move(2 * stageWidth / 10, -2 * stageHeight / 20);
                rotateState = 3;
                break;
            
            case 1:
                move2();
                f = false;
                for(Block b : blocks) {
                    if(hits(b)) {
                        f = true;
                        break;
                    }
                }
                f = f || (r1.hitsWall().x || r2.hitsWall().x || r3.hitsWall().x || r4.hitsWall().x);
                if(!f) return this;
                px--;
                r1.move(-stageWidth / 10, 0);
                r2.move(-stageWidth / 10, 0);
                r3.move(-stageWidth / 10, 0);
                r4.move(-stageWidth / 10, 0);
                f = false;
                for(Block b : blocks) {
                    if(hits(b)) {
                        f = true;
                        break;
                    }
                }
                f = f || (r1.hitsWall().x || r2.hitsWall().x || r3.hitsWall().x || r4.hitsWall().x);
                if(!f) return this;
                px += 3;
                r1.move(-stageWidth / 10, 0);
                r2.move(-stageWidth / 10, 0);
                r3.move(-stageWidth / 10, 0);
                r4.move(-stageWidth / 10, 0);
                f = false;
                for(Block b : blocks) {
                    if(hits(b)) {
                        f = true;
                        break;
                    }
                }
                f = f || (r1.hitsWall().x || r2.hitsWall().x || r3.hitsWall().x || r4.hitsWall().x);
                if(!f) return this;
                px -= 3;
                py -= 2;
                r1.move(-3 * stageWidth / 10, -2 * stageHeight / 20);
                r2.move(-3 * stageWidth / 10, -2 * stageHeight / 20);
                r3.move(-3 * stageWidth / 10, -2 * stageHeight / 20);
                r4.move(-3 * stageWidth / 10, -2 * stageHeight / 20);
                f = false;
                for(Block b : blocks) {
                    if(hits(b)) {
                        f = true;
                        break;
                    }
                }
                f = f || (r1.hitsWall().x || r2.hitsWall().x || r3.hitsWall().x || r4.hitsWall().x);
                if(!f) return this;
                px += 3;
                py += 3;
                r1.move(3 * stageWidth / 10, 3 * stageHeight / 20);
                r2.move(3 * stageWidth / 10, 3 * stageHeight / 20);
                r3.move(3 * stageWidth / 10, 3 * stageHeight / 20);
                r4.move(3 * stageWidth / 10, 3 * stageHeight / 20);
                f = false;
                for(Block b : blocks) {
                    if(hits(b)) {
                        f = true;
                        break;
                    }
                }
                f = f || (r1.hitsWall().x || r2.hitsWall().x || r3.hitsWall().x || r4.hitsWall().x);
                if(!f) return this;
                px -= 2;
                py -= 2;
                r1.move(-2 * stageWidth / 10, -2 * stageHeight / 20);
                r2.move(-2 * stageWidth / 10, -2 * stageHeight / 20);
                r3.move(-2 * stageWidth / 10, -2 * stageHeight / 20);
                r4.move(-2 * stageWidth / 10, -2 * stageHeight / 20);
                rotateState = 0;
                break;

            case 2:
                px++;
                r1.move(stageWidth / 10, 0);
                r2.move(stageWidth / 10, 0);
                r3.move(stageWidth / 10, 0);
                r4.move(stageWidth / 10, 0);
                f = false;
                for(Block b : blocks) {
                    if(hits(b)) {
                        f = true;
                        break;
                    }
                }
                f = f || (r1.hitsWall().x || r2.hitsWall().x || r3.hitsWall().x || r4.hitsWall().x);
                if(!f) return this;
                px -= 2;
                r1.move(-2 * stageWidth / 10, 0);
                r2.move(-2 * stageWidth / 10, 0);
                r3.move(-2 * stageWidth / 10, 0);
                r4.move(-2 * stageWidth / 10, 0);
                f = false;
                for(Block b : blocks) {
                    if(hits(b)) {
                        f = true;
                        break;
                    }
                }
                f = f || (r1.hitsWall().x || r2.hitsWall().x || r3.hitsWall().x || r4.hitsWall().x);
                if(!f) return this;
                px += 3;
                r1.move(3 * stageWidth / 10, 0);
                r2.move(3 * stageWidth / 10, 0);
                r3.move(3 * stageWidth / 10, 0);
                r4.move(3 * stageWidth / 10, 0);
                f = false;
                for(Block b : blocks) {
                    if(hits(b)) {
                        f = true;
                        break;
                    }
                }
                f = f || (r1.hitsWall().x || r2.hitsWall().x || r3.hitsWall().x || r4.hitsWall().x);
                if(!f) return this;
                py += 2;
                r1.move(0, 2 * stageHeight / 20);
                r2.move(0, 2 * stageHeight / 20);
                r3.move(0, 2 * stageHeight / 20);
                r4.move(0, 2 * stageHeight / 20);
                f = false;
                for(Block b : blocks) {
                    if(hits(b)) {
                        f = true;
                        break;
                    }
                }
                f = f || (r1.hitsWall().x || r2.hitsWall().x || r3.hitsWall().x || r4.hitsWall().x);
                if(!f) return this;
                px -= 3;
                py -= 3;
                r1.move(-3 * stageWidth / 10, -3 * stageHeight / 20);
                r2.move(-3 * stageWidth / 10, -3 * stageHeight / 20);
                r3.move(-3 * stageWidth / 10, -3 * stageHeight / 20);
                r4.move(-3 * stageWidth / 10, -3 * stageHeight / 20);
                f = false;
                for(Block b : blocks) {
                    if(hits(b)) {
                        f = true;
                        break;
                    }
                }
                f = f || (r1.hitsWall().x || r2.hitsWall().x || r3.hitsWall().x || r4.hitsWall().x);
                if(!f) return this;
                px -= 2;
                py += 2;
                r1.move(-2 * stageWidth / 10, 2 * stageHeight / 20);
                r2.move(-2 * stageWidth / 10, 2 * stageHeight / 20);
                r3.move(-2 * stageWidth / 10, 2 * stageHeight / 20);
                r4.move(-2 * stageWidth / 10, 2 * stageHeight / 20);
                rotateState = 1;
                break;

            case 3:
                py--;
                r1.move(0, -stageHeight / 20);
                r2.move(0, -stageHeight / 20);
                r3.move(0, -stageHeight / 20);
                r4.move(0, -stageHeight / 20);
                f = false;
                for(Block b : blocks) {
                    if(hits(b)) {
                        f = true;
                        break;
                    }
                }
                f = f || (r1.hitsWall().x || r2.hitsWall().x || r3.hitsWall().x || r4.hitsWall().x);
                if(!f) return this;
                px++;
                r1.move(stageWidth / 10, 0);
                r2.move(stageWidth / 10, 0);
                r3.move(stageWidth / 10, 0);
                r4.move(stageWidth / 10, 0);
                f = false;
                for(Block b : blocks) {
                    if(hits(b)) {
                        f = true;
                        break;
                    }
                }
                f = f || (r1.hitsWall().x || r2.hitsWall().x || r3.hitsWall().x || r4.hitsWall().x);
                if(!f) return this;
                px -= 3;
                r1.move(-3 * stageWidth / 10, 0);
                r2.move(-3 * stageWidth / 10, 0);
                r3.move(-3 * stageWidth / 10, 0);
                r4.move(-3 * stageWidth / 10, 0);
                f = false;
                for(Block b : blocks) {
                    if(hits(b)) {
                        f = true;
                        break;
                    }
                }
                f = f || (r1.hitsWall().x || r2.hitsWall().x || r3.hitsWall().x || r4.hitsWall().x);
                if(!f) return this;
                px += 3;
                py += 2;
                r1.move(0, 2 * stageHeight / 20);
                r2.move(0, 2 * stageHeight / 20);
                r3.move(0, 2 * stageHeight / 20);
                r4.move(0, 2 * stageHeight / 20);
                f = false;
                for(Block b : blocks) {
                    if(hits(b)) {
                        f = true;
                        break;
                    }
                }
                f = f || (r1.hitsWall().x || r2.hitsWall().x || r3.hitsWall().x || r4.hitsWall().x);
                if(!f) return this;
                px -= 3;
                py -= 3;
                r1.move(-3 * stageWidth / 10, -3 * stageHeight / 20);
                r2.move(-3 * stageWidth / 10, -3 * stageHeight / 20);
                r3.move(-3 * stageWidth / 10, -3 * stageHeight / 20);
                r4.move(-3 * stageWidth / 10, -3 * stageHeight / 20);
                f = false;
                for(Block b : blocks) {
                    if(hits(b)) {
                        f = true;
                        break;
                    }
                }
                f = f || (r1.hitsWall().x || r2.hitsWall().x || r3.hitsWall().x || r4.hitsWall().x);
                if(!f) return this;
                px += 2;
                py += 2;
                r1.move(2 * stageWidth / 10, 2 * stageHeight / 20);
                r2.move(2 * stageWidth / 10, 2 * stageHeight / 20);
                r3.move(2 * stageWidth / 10, 2 * stageHeight / 20);
                r4.move(2 * stageWidth / 10, 2 * stageHeight / 20);
                rotateState = 2;
                break;
        }
        r1.moveTo(py * stageHeight / 20 - r1.getPos().y + px * stageWidth / 10, r1.getPos().x - px * stageWidth / 10 + py * stageHeight / 20);
        r3.moveTo(py * stageHeight / 20 - r3.getPos().y + px * stageWidth / 10, r3.getPos().x - px * stageWidth / 10 + py * stageHeight / 20);
        r4.moveTo(py * stageHeight / 20 - r4.getPos().y + px * stageWidth / 10, r4.getPos().x - px * stageWidth / 10 + py * stageHeight / 20);
        f = false;
        return this;
    }

    @Override
    BlockI rotateRight() {
        if(!active) return this;
        boolean f = false;
        lockDown++;
        r1.moveTo(py * stageHeight / 20 - r1.getPos().y + px * stageWidth / 10, r1.getPos().x - px * stageWidth / 10 + py * stageHeight / 20);
        r3.moveTo(py * stageHeight / 20 - r3.getPos().y + px * stageWidth / 10, r3.getPos().x - px * stageWidth / 10 + py * stageHeight / 20);
        r4.moveTo(py * stageHeight / 20 - r4.getPos().y + px * stageWidth / 10, r4.getPos().x - px * stageWidth / 10 + py * stageHeight / 20);
        rotateState--;
        if(rotateState == -1) rotateState = 3;
        switch(rotateState) {
            case 0:
                py--;
                r1.move(0, -stageHeight / 20);
                r2.move(0, -stageHeight / 20);
                r3.move(0, -stageHeight / 20);
                r4.move(0, -stageHeight / 20);
                f = false;
                for(Block b : blocks) {
                    if(hits(b)) {
                        f = true;
                        break;
                    }
                }
                f = f || (r1.hitsWall().x || r2.hitsWall().x || r3.hitsWall().x || r4.hitsWall().x);
                if(!f) return this;
                px -= 2;
                r1.move(-2 * stageWidth / 10, 0);
                r2.move(-2 * stageWidth / 10, 0);
                r3.move(-2 * stageWidth / 10, 0);
                r4.move(-2 * stageWidth / 10, 0);
                f = false;
                for(Block b : blocks) {
                    if(hits(b)) {
                        f = true;
                        break;
                    }
                }
                f = f || (r1.hitsWall().x || r2.hitsWall().x || r3.hitsWall().x || r4.hitsWall().x);
                if(!f) return this;
                px += 3;
                r1.move(3 * stageWidth / 10, 0);
                r2.move(3 * stageWidth / 10, 0);
                r3.move(3 * stageWidth / 10, 0);
                r4.move(3 * stageWidth / 10, 0);
                f = false;
                for(Block b : blocks) {
                    if(hits(b)) {
                        f = true;
                        break;
                    }
                }
                f = f || (r1.hitsWall().x || r2.hitsWall().x || r3.hitsWall().x || r4.hitsWall().x);
                if(!f) return this;
                py += 2;
                r1.move(0, 2 * stageHeight / 20);
                r2.move(0, 2 * stageHeight / 20);
                r3.move(0, 2 * stageHeight / 20);
                r4.move(0, 2 * stageHeight / 20);
                f = false;
                for(Block b : blocks) {
                    if(hits(b)) {
                        f = true;
                        break;
                    }
                }
                f = f || (r1.hitsWall().x || r2.hitsWall().x || r3.hitsWall().x || r4.hitsWall().x);
                if(!f) return this;
                px -= 3;
                py -= 3;
                r1.move(-3 * stageWidth / 10, -3 * stageHeight / 20);
                r2.move(-3 * stageWidth / 10, -3 * stageHeight / 20);
                r3.move(-3 * stageWidth / 10, -3 * stageHeight / 20);
                r4.move(-3 * stageWidth / 10, -3 * stageHeight / 20);
                f = false;
                for(Block b : blocks) {
                    if(hits(b)) {
                        f = true;
                        break;
                    }
                }
                f = f || (r1.hitsWall().x || r2.hitsWall().x || r3.hitsWall().x || r4.hitsWall().x);
                if(!f) return this;
                px += 2;
                py += 2;
                r1.move(2 * stageWidth / 10, 2 * stageHeight / 20);
                r2.move(2 * stageWidth / 10, 2 * stageHeight / 20);
                r3.move(2 * stageWidth / 10, 2 * stageHeight / 20);
                r4.move(2 * stageWidth / 10, 2 * stageHeight / 20);
                rotateState = 1;
                break;

            case 1:
                px--;
                r1.move(-stageWidth / 10, 0);
                r2.move(-stageWidth / 10, 0);
                r3.move(-stageWidth / 10, 0);
                r4.move(-stageWidth / 10, 0);
                f = false;
                for(Block b : blocks) {
                    if(hits(b)) {
                        f = true;
                        break;
                    }
                }
                f = f || (r1.hitsWall().x || r2.hitsWall().x || r3.hitsWall().x || r4.hitsWall().x);
                if(!f) return this;
                px += 2;
                r1.move(2 * stageWidth / 10, 0);
                r2.move(2 * stageWidth / 10, 0);
                r3.move(2 * stageWidth / 10, 0);
                r4.move(2 * stageWidth / 10, 0);
                f = false;
                for(Block b : blocks) {
                    if(hits(b)) {
                        f = true;
                        break;
                    }
                }
                f = f || (r1.hitsWall().x || r2.hitsWall().x || r3.hitsWall().x || r4.hitsWall().x);
                if(!f) return this;
                px -= 3;
                r1.move(-3 * stageWidth / 10, 0);
                r2.move(-3 * stageWidth / 10, 0);
                r3.move(-3 * stageWidth / 10, 0);
                r4.move(-3 * stageWidth / 10, 0);
                f = false;
                for(Block b : blocks) {
                    if(hits(b)) {
                        f = true;
                        break;
                    }
                }
                f = f || (r1.hitsWall().x || r2.hitsWall().x || r3.hitsWall().x || r4.hitsWall().x);
                if(!f) return this;
                px += 3;
                py--;
                r1.move(3 * stageWidth / 10, -stageHeight / 20);
                r2.move(3 * stageWidth / 10, -stageHeight / 20);
                r3.move(3 * stageWidth / 10, -stageHeight / 20);
                r4.move(3 * stageWidth / 10, -stageHeight / 20);
                f = false;
                for(Block b : blocks) {
                    if(hits(b)) {
                        f = true;
                        break;
                    }
                }
                f = f || (r1.hitsWall().x || r2.hitsWall().x || r3.hitsWall().x || r4.hitsWall().x);
                if(!f) return this;
                px -= 3;
                py += 3;
                r1.move(-3 * stageWidth / 10, 3 * stageHeight / 20);
                r2.move(-3 * stageWidth / 10, 3 * stageHeight / 20);
                r3.move(-3 * stageWidth / 10, 3 * stageHeight / 20);
                r4.move(-3 * stageWidth / 10, 3 * stageHeight / 20);
                f = false;
                for(Block b : blocks) {
                    if(hits(b)) {
                        f = true;
                        break;
                    }
                }
                f = f || (r1.hitsWall().x || r2.hitsWall().x || r3.hitsWall().x || r4.hitsWall().x);
                if(!f) return this;
                px += 2;
                py -= 2;
                r1.move(2 * stageWidth / 10, -2 * stageHeight / 20);
                r2.move(2 * stageWidth / 10, -2 * stageHeight / 20);
                r3.move(2 * stageWidth / 10, -2 * stageHeight / 20);
                r4.move(2 * stageWidth / 10, -2 * stageHeight / 20);
                rotateState = 2;
                break;

            case 2:
                move2();
                f = false;
                for(Block b : blocks) {
                    if(hits(b)) {
                        f = true;
                        break;
                    }
                }
                f = f || (r1.hitsWall().x || r2.hitsWall().x || r3.hitsWall().x || r4.hitsWall().x);
                if(!f) return this;
                px--;
                r1.move(-stageWidth / 10, 0);
                r2.move(-stageWidth / 10, 0);
                r3.move(-stageWidth / 10, 0);
                r4.move(-stageWidth / 10, 0);
                f = false;
                for(Block b : blocks) {
                    if(hits(b)) {
                        f = true;
                        break;
                    }
                }
                f = f || (r1.hitsWall().x || r2.hitsWall().x || r3.hitsWall().x || r4.hitsWall().x);
                if(!f) return this;
                px += 3;
                r1.move(3 * stageWidth / 10, 0);
                r2.move(3 * stageWidth / 10, 0);
                r3.move(3 * stageWidth / 10, 0);
                r4.move(3 * stageWidth / 10, 0);
                f = false;
                for(Block b : blocks) {
                    if(hits(b)) {
                        f = true;
                        break;
                    }
                }
                f = f || (r1.hitsWall().x || r2.hitsWall().x || r3.hitsWall().x || r4.hitsWall().x);
                if(!f) return this;
                px -= 3;
                py -= 2;
                r1.move(-3 * stageWidth / 10, -2 * stageHeight / 20);
                r2.move(-3 * stageWidth / 10, -2 * stageHeight / 20);
                r3.move(-3 * stageWidth / 10, -2 * stageHeight / 20);
                r4.move(-3 * stageWidth / 10, -2 * stageHeight / 20);
                f = false;
                for(Block b : blocks) {
                    if(hits(b)) {
                        f = true;
                        break;
                    }
                }
                f = f || (r1.hitsWall().x || r2.hitsWall().x || r3.hitsWall().x || r4.hitsWall().x);
                if(!f) return this;
                px += 3;
                py += 3;
                r1.move(3 * stageWidth / 10, 3 * stageHeight / 20);
                r2.move(3 * stageWidth / 10, 3 * stageHeight / 20);
                r3.move(3 * stageWidth / 10, 3 * stageHeight / 20);
                r4.move(3 * stageWidth / 10, 3 * stageHeight / 20);
                f = false;
                for(Block b : blocks) {
                    if(hits(b)) {
                        f = true;
                        break;
                    }
                }
                f = f || (r1.hitsWall().x || r2.hitsWall().x || r3.hitsWall().x || r4.hitsWall().x);
                if(!f) return this;
                px -= 2;
                py -= 2;
                r1.move(-2 * stageWidth / 10, -2 * stageHeight / 20);
                r2.move(-2 * stageWidth / 10, -2 * stageHeight / 20);
                r3.move(-2 * stageWidth / 10, -2 * stageHeight / 20);
                r4.move(-2 * stageWidth / 10, -2 * stageHeight / 20);
                rotateState = 3;
                break;

            case 3:
                px++;
                r1.move(stageWidth / 10, 0);
                r2.move(stageWidth / 10, 0);
                r3.move(stageWidth / 10, 0);
                r4.move(stageWidth / 10, 0);
                f = false;
                for(Block b : blocks) {
                    if(hits(b)) {
                        f = true;
                        break;
                    }
                }
                f = f || (r1.hitsWall().x || r2.hitsWall().x || r3.hitsWall().x || r4.hitsWall().x);
                if(!f) return this;
                px -= 2;
                r1.move(-2 * stageWidth / 10, 0);
                r2.move(-2 * stageWidth / 10, 0);
                r3.move(-2 * stageWidth / 10, 0);
                r4.move(-2 * stageWidth / 10, 0);
                f = false;
                for(Block b : blocks) {
                    if(hits(b)) {
                        f = true;
                        break;
                    }
                }
                f = f || (r1.hitsWall().x || r2.hitsWall().x || r3.hitsWall().x || r4.hitsWall().x);
                if(!f) return this;
                px += 3;
                r1.move(3 * stageWidth / 10, 0);
                r2.move(3 * stageWidth / 10, 0);
                r3.move(3 * stageWidth / 10, 0);
                r4.move(3 * stageWidth / 10, 0);
                f = false;
                for(Block b : blocks) {
                    if(hits(b)) {
                        f = true;
                        break;
                    }
                }
                f = f || (r1.hitsWall().x || r2.hitsWall().x || r3.hitsWall().x || r4.hitsWall().x);
                if(!f) return this;
                px -= 3;
                py++;
                r1.move(-3 * stageWidth / 10, stageHeight / 20);
                r2.move(-3 * stageWidth / 10, stageHeight / 20);
                r3.move(-3 * stageWidth / 10, stageHeight / 20);
                r4.move(-3 * stageWidth / 10, stageHeight / 20);
                f = false;
                for(Block b : blocks) {
                    if(hits(b)) {
                        f = true;
                        break;
                    }
                }
                f = f || (r1.hitsWall().x || r2.hitsWall().x || r3.hitsWall().x || r4.hitsWall().x);
                if(!f) return this;
                px += 3;
                py -= 3;
                r1.move(3 * stageWidth / 10, -3 * stageHeight / 20);
                r2.move(3 * stageWidth / 10, -3 * stageHeight / 20);
                r3.move(3 * stageWidth / 10, -3 * stageHeight / 20);
                r4.move(3 * stageWidth / 10, -3 * stageHeight / 20);
                f = false;
                for(Block b : blocks) {
                    if(hits(b)) {
                        f = true;
                        break;
                    }
                }
                f = f || (r1.hitsWall().x || r2.hitsWall().x || r3.hitsWall().x || r4.hitsWall().x);
                if(!f) return this;
                px -= 2;
                py += 2;
                r1.move(-2 * stageWidth / 10, 2 * stageHeight / 20);
                r2.move(-2 * stageWidth / 10, 2 * stageHeight / 20);
                r3.move(-2 * stageWidth / 10, 2 * stageHeight / 20);
                r4.move(-2 * stageWidth / 10, 2 * stageHeight / 20);
                rotateState = 0;
                break;
        }
        r1.moveTo(r1.getPos().y - py * stageHeight / 20 + px * stageWidth / 10, px * stageWidth / 10 - r1.getPos().x + py * stageHeight / 20);
        r3.moveTo(r3.getPos().y - py * stageHeight / 20 + px * stageWidth / 10, px * stageWidth / 10 - r3.getPos().x + py * stageHeight / 20);
        r4.moveTo(r4.getPos().y - py * stageHeight / 20 + px * stageWidth / 10, px * stageWidth / 10 - r4.getPos().x + py * stageHeight / 20);
        f = false;
        return this;
    }
}

class BlockO extends Block {

    BlockO() {
        px = 4;
        py = -1;
        t = 0;
        rotateState = 0;
        lockDown = 0;
        r1 = new Rect(px * stageWidth / 10, (py - 1) * stageHeight / 20, stageWidth / 10, stageHeight / 20).setColor(YELLOW);
        r2 = new Rect(px * stageWidth / 10, py * stageHeight / 20, stageWidth / 10, stageHeight / 20).setColor(YELLOW);
        r3 = new Rect((px + 1) * stageWidth / 10, py * stageHeight / 20, stageWidth / 10, stageHeight / 20).setColor(YELLOW);
        r4 = new Rect((px + 1) * stageWidth / 10, (py - 1) * stageHeight / 20, stageWidth / 10, stageHeight / 20).setColor(YELLOW);
        active = true;
        v1 = true;
        v2 = true;
        v3 = true;
        v4 = true;
        spinFlag = false;
        c = YELLOW;
        stop = false;
        for(Block b : blocks) {
            if(hits(b)) {
                stop = true;
                break;
            }
        }
        if(stop) active = false;
    }

    @Override
    BlockO rotateRight() {
        return this;
    }

    @Override
    BlockO rotateLeft() {
        return this;
    }
}

boolean[] flag = {false, false, false, false, false, false, false};
int[] order = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0};
int count = 0, speed = 0, level = 1, state = 0, t1 = 0, t2 = 0, ren = 0, tetrisCount = 0, replayTime = 0, lines = 0, tSpinCount = 0, v = 1000, keyPressedTime = 0;
Block block, hold = null;
Vector<Block> blocks = new Vector();
final int stageWidth = 300, stageHeight = 600;
boolean canHold = true, tSpinFlag = false, backToBackFlag = false;
int score = 0;
String msg = "";

void setup() {
    size(500, 600);
    speed = (int)frameRate;
}

void draw() {
    switch(state) {
        case 0:
            background(BLACK);
            textSize(32);
            fill(WHITE);
            textAlign(CENTER);
            text("TETRIS", 100, 200, 300, 50);
            textSize(20);
            text("Press Space to Start.", 100, 400, 300, 50);
            break;
        
        case 1:
            translate(100, 0);
            drawStage();
            if(millis() - t2 > v) {
                block.move();
                t2 = millis();
            }
            imageBlock();
            block.show();
            for(Block b : blocks) b.show();
            switch(msg) {
                case "Back-to-Back T-Spin Single":
                case "T-Spin Single":
                case "Single":
                    fill(color(48, 80, 255));
                    break;

                case "Back-to-Back T-Spin Double":
                case "T-Spin Double":
                case "Double":
                    fill(color(0, 255, 48));
                    break;

                case "Back-to-Back T-Spin Triple":
                case "T-Spin Triple":
                case "Triple":
                    fill(color(225, 80, 0));
                    break;

                case "Back-to-Back Tetris":
                case "Tetris":
                case "Perfect":
                    fill(color(225, 225, 0));
                    break;
            }
            if(msg != "") {
                textSize(32);
                textAlign(CENTER);
                text(msg, 0, 225, 300, 100);
                textSize(24);
                if(ren > 1) text(ren + " Combo!", 50, 325, 200, 50);
                t1++;
            }
            if(t1 == speed) {
                msg = "";
                t1 = 0;
            }
            if(!block.isActive()) {
                if(block.getClass().getTypeName() == "Tetris$BlockT") tSpinFlag = block.getSpinFlag();
                blocks.add(block);
                count++;
                if(count == 7) {
                    count = 0;
                    makeOrder();
                }
                update();
                canHold = true;
            }
            if(keyPressed && (keyPressedTime == 0 || millis() - keyPressedTime > v / 20)) {
                keyPressedTime = millis();
                if(key == CODED) {
                    if(keyCode == DOWN) {
                        score++;
                        block.move();
                    }
                }
            }
            break;
        
        case 2:
            background(BLACK);
            textSize(32);
            fill(WHITE);
            textAlign(CENTER);
            text("Level: " + level, 100, 140, 300, 50);
            text("Score:", 100, 200, 300, 50);
            text(score, 250, 290);
            textSize(20);
            text("Replay: [ENTER]", 100, 400, 300, 50);
            text("Exit: [ESC]", 100, 450, 300, 50);
    }
}

void drawStage() {
    background(BLACK);
    stroke(WHITE);
    for(int x = 0; x <= stageWidth; x += stageWidth / 10) {
        line(x, 0, x, stageHeight);
    }
    for(int y = 0; y <= stageHeight; y += stageHeight / 20) {
        line(0, y, stageWidth, y);
    }
    noFill();
    rect(-80, 40, 60, 60);
    if(hold != null) {
        switch(hold.getClass().getTypeName()) {
            case "Tetris$BlockT":
                hold = new BlockT();
                new Rect(-57, 56, 14, 14, MAGENTA).showc();
                new Rect(-71, 70, 14, 14, MAGENTA).showc();
                new Rect(-57, 70, 14, 14, MAGENTA).showc();
                new Rect(-43, 70, 14, 14, MAGENTA).showc();
                break;
            
            case "Tetris$BlockS":
                hold = new BlockS();
                new Rect(-57, 56, 14, 14, GREEN).showc();
                new Rect(-71, 70, 14, 14, GREEN).showc();
                new Rect(-57, 70, 14, 14, GREEN).showc();
                new Rect(-43, 56, 14, 14, GREEN).showc();
                break;

            case "Tetris$BlockZ":
                hold = new BlockZ();
                new Rect(-57, 56, 14, 14, RED).showc();
                new Rect(-71, 56, 14, 14, RED).showc();
                new Rect(-57, 70, 14, 14, RED).showc();
                new Rect(-43, 70, 14, 14, RED).showc();
                break;

            case "Tetris$BlockJ":
                hold = new BlockJ();
                new Rect(-71, 56, 14, 14, BLUE).showc();
                new Rect(-71, 70, 14, 14, BLUE).showc();
                new Rect(-57, 70, 14, 14, BLUE).showc();
                new Rect(-43, 70, 14, 14, BLUE).showc();
                break;

            case "Tetris$BlockL":
                hold = new BlockL();
                new Rect(-43, 56, 14, 14, color(255, 165, 0)).showc();
                new Rect(-71, 70, 14, 14, color(255, 165, 0)).showc();
                new Rect(-57, 70, 14, 14, color(255, 165, 0)).showc();
                new Rect(-43, 70, 14, 14, color(255, 165, 0)).showc();
                break;
            
            case "Tetris$BlockI":
                hold = new BlockI();
                new Rect(-78, 70, 14, 14, color(0, 191, 255)).showc();
                new Rect(-64, 70, 14, 14, color(0, 191, 255)).showc();
                new Rect(-50, 70, 14, 14, color(0, 191, 255)).showc();
                new Rect(-36, 70, 14, 14, color(0, 191, 255)).showc();
                break;
            
            case "Tetris$BlockO":
                hold = new BlockO();
                new Rect(-64, 56, 14, 14, YELLOW).showc();
                new Rect(-64, 70, 14, 14, YELLOW).showc();
                new Rect(-50, 56, 14, 14, YELLOW).showc();
                new Rect(-50, 70, 14, 14, YELLOW).showc();
                break;
        }
    }
    textSize(20);
    textAlign(CENTER);
    fill(WHITE);
    text("NEXT", stageWidth, 10, 100, 50);
    for(int i = 0; i < 5; i++) {
        fill(BLACK);
        rect(stageWidth + 20, i * 80 + 40, 60, 60);
        switch(order[count + i + 1]) {
            case 0:
                new Rect(stageWidth + 43, i * 80 + 56, 14, 14, MAGENTA).showc();
                new Rect(stageWidth + 29, i * 80 + 70, 14, 14, MAGENTA).showc();
                new Rect(stageWidth + 43, i * 80 + 70, 14, 14, MAGENTA).showc();
                new Rect(stageWidth + 57, i * 80 + 70, 14, 14, MAGENTA).showc();
                break;
            
            case 1:
                new Rect(stageWidth + 43, i * 80 + 56, 14, 14, GREEN).showc();
                new Rect(stageWidth + 29, i * 80 + 70, 14, 14, GREEN).showc();
                new Rect(stageWidth + 43, i * 80 + 70, 14, 14, GREEN).showc();
                new Rect(stageWidth + 57, i * 80 + 56, 14, 14, GREEN).showc();
                break;

            case 2:
                new Rect(stageWidth + 43, i * 80 + 56, 14, 14, RED).showc();
                new Rect(stageWidth + 29, i * 80 + 56, 14, 14, RED).showc();
                new Rect(stageWidth + 43, i * 80 + 70, 14, 14, RED).showc();
                new Rect(stageWidth + 57, i * 80 + 70, 14, 14, RED).showc();
                break;

            case 3:
                new Rect(stageWidth + 29, i * 80 + 56, 14, 14, BLUE).showc();
                new Rect(stageWidth + 29, i * 80 + 70, 14, 14, BLUE).showc();
                new Rect(stageWidth + 43, i * 80 + 70, 14, 14, BLUE).showc();
                new Rect(stageWidth + 57, i * 80 + 70, 14, 14, BLUE).showc();
                break;

            case 4:
                new Rect(stageWidth + 57, i * 80 + 56, 14, 14, color(255, 165, 0)).showc();
                new Rect(stageWidth + 29, i * 80 + 70, 14, 14, color(255, 165, 0)).showc();
                new Rect(stageWidth + 43, i * 80 + 70, 14, 14, color(255, 165, 0)).showc();
                new Rect(stageWidth + 57, i * 80 + 70, 14, 14, color(255, 165, 0)).showc();
                break;
            
            case 5:
                new Rect(stageWidth + 22, i * 80 + 70, 14, 14, color(0, 191, 255)).showc();
                new Rect(stageWidth + 36, i * 80 + 70, 14, 14, color(0, 191, 255)).showc();
                new Rect(stageWidth + 50, i * 80 + 70, 14, 14, color(0, 191, 255)).showc();
                new Rect(stageWidth + 64, i * 80 + 70, 14, 14, color(0, 191, 255)).showc();
                break;
            
            case 6:
                new Rect(stageWidth + 36, i * 80 + 56, 14, 14, YELLOW).showc();
                new Rect(stageWidth + 36, i * 80 + 70, 14, 14, YELLOW).showc();
                new Rect(stageWidth + 50, i * 80 + 56, 14, 14, YELLOW).showc();
                new Rect(stageWidth + 50, i * 80 + 70, 14, 14, YELLOW).showc();
                break;
        }
    }
    int ms = millis() - replayTime;
    int min = ms / 60000;
    ms -= min * 60000;
    float sec = ms / 1000.0;
    textSize(20);
    fill(WHITE);
    textAlign(CENTER);
    text("HOLD", -100, 10, 100, 50);
    textSize(16);
    text("Level: " + level, -100, 160, 100, 50);
    text("Score: " + nf(score, 6), -100, 200, 100, 50);
    text("Time:", -100, 270, 100, 50);
    text(nf(min, 2) + ":" + nf(sec, 2, 2), -100, 300, 100, 50);
    text("Lines: " + nf(lines, 3), -100, 350, 100, 50);
    text("Tetrises: " + nf(tetrisCount, 3), -100, 390, 100, 50);
    text("T-Spins: " + nf(tSpinCount, 3), -100, 450, 100, 50);
}

void update() {
    for(Block b : blocks) {
        if(b.hasLine21()) {
            state++;
            return;
        }
    }

    switch(order[count]) {
        case 0:
            block = new BlockT();
            break;
            
        case 1:
            block = new BlockS();
            break;
        
        case 2:
            block = new BlockZ();
            break;

        case 3:
            block = new BlockJ();
            break;

        case 4:
            block = new BlockL();
            break;

        case 5:
            block = new BlockI();
            break;

        case 6:
            block = new BlockO();
    }
    if(!block.isActive()) {
        block = null;
        state++;
        return;
    }
    
    int x = 0, y = 0, lineCount = 0;
    color c = WHITE;
    boolean f = true;
    for(int i = 0; i < 20; i++) {
        for(int j = 0; j < 10; j++) {
            x = 100 + j * stageWidth / 10 + stageWidth / 20;
            y = i * stageHeight / 20 + stageHeight / 40;
            c = get(x, y);
            if(c != MAGENTA && c != GREEN && c != RED && c != BLUE && c != color(255, 165, 0) && c != color(0, 191, 255) && c != YELLOW) {
                f = false;
                break;
            }
        }
        if(f) {
            for(Block b : blocks) {
                b.delete(i);
            }
            for(Block b : blocks) {
                b.fix(i);
            }
            lineCount++;
        }
        f = true;
    }
    for(int i = 0; i < blocks.size(); i++) {
        if(blocks.get(i).allDelete()) {
            blocks.remove(i);
            i--;
        }
    }
    switch(lineCount) {
        case 0:
            ren = 0;
            backToBackFlag = false;
            break;

        case 1:
            ren++;
            if(tSpinFlag) {
                tSpinCount++;
                score += 800 * level * pow(2, ren - 1);
                if(backToBackFlag) {
                    score += 400 * level * pow(2, ren - 1);
                    msg = "Back-to-Back T-Spin Single";
                }
                else msg = "T-Spin Single";
                backToBackFlag = true;
            }
            else {
                msg = "Single";
                score += 100 * level * pow(2, ren - 1);
                backToBackFlag = false;
            }
            if(lines % 10 > (lines + 1) % 10) {
                if(level < 4) v -= 100;
                else if(level < 8) v -= 50;
                else if(level < 12) v -= 40;
                else if(level < 16) v -= 30;
                else if(level < 20) v -= 20;
                else if(level < 24) v -= 10;
                else if(level < 28) v -= 5;
                else level--;
                level++;
            }
            lines++;
            break;

        case 2:
            ren++;
            if(tSpinFlag) {
                tSpinCount++;
                score += 1200 * level * pow(2, ren - 1);
                if(backToBackFlag) {
                    score += 600 * level * pow(2, ren - 1);
                    msg = "Back-to-Back T-Spin Double";
                }
                else msg = "T-Spin Double";
                backToBackFlag = true;
            }
            else {
                msg = "Double";
                score += 300 * level * pow(2, ren - 1);
                backToBackFlag = false;
            }
            if(lines % 10 > (lines + 2) % 10) {
                if(level < 4) v -= 100;
                else if(level < 8) v -= 50;
                else if(level < 12) v -= 40;
                else if(level < 16) v -= 30;
                else if(level < 20) v -= 20;
                else if(level < 24) v -= 10;
                else if(level < 28) v -= 5;
                else level--;
                level++;
            }
            lines += 2;
            break;

        case 3:
            ren++;
            if(tSpinFlag) {
                tSpinCount++;
                score += 1600 * level * pow(2, ren - 1);
                if(backToBackFlag) {
                    score += 800 * level * pow(2, ren - 1);
                    msg = "Back-to-Back T-Spin Triple";
                }
                else msg = "T-Spin Triple";
                backToBackFlag = true;
            }
            else {
                msg = "Triple";
                score += 500 * level * pow(2, ren - 1);
                backToBackFlag = false;
            }
            if(lines % 10 > (lines + 3) % 10) {
                if(level < 4) v -= 100;
                else if(level < 8) v -= 50;
                else if(level < 12) v -= 40;
                else if(level < 16) v -= 30;
                else if(level < 20) v -= 20;
                else if(level < 24) v -= 10;
                else if(level < 28) v -= 5;
                else level--;
                level++;
            }
            lines += 3;
            break;

        case 4:
            ren++;
            tetrisCount++;
            score += 800 * level * pow(2, ren - 1);
            if(backToBackFlag) {
                score += 400 * level * pow(2, ren - 1);
                msg = "Back-to-Back Tetris";
            }
            else msg = "Tetris";
            if(lines % 10 > (lines + 4) % 10) {
                if(level < 4) v -= 100;
                else if(level < 8) v -= 50;
                else if(level < 12) v -= 40;
                else if(level < 16) v -= 30;
                else if(level < 20) v -= 20;
                else if(level < 24) v -= 10;
                else if(level < 28) v -= 5;
                else level--;
                level++;
            }
            lines += 4;
            backToBackFlag = true;
            break;
    }
    if(blocks.size() == 0 && lines > 1) msg = "Perfect";
    tSpinFlag = false;
}

void init() {
    int result = (int)random(7);
    for(int i = 0; i < 7; i++) {
        flag[i] = false;
        order[2 * i] = 0;
        order[2 * i + 1] = 0;
    }
    for(int i = 0; i < 7; i++) {
        while(flag[result]) result = (int)random(7);
        order[i] = result;
        flag[result] = true;
    }
    result = (int)random(7);
    for(int i = 0; i < 7; i++) flag[i] = false;
    for(int i = 7; i < 14; i++) {
        while(flag[result]) result = (int)random(7);
        order[i] = result;
        flag[result] = true;
    }
}

void makeOrder() {
    int result = (int)random(7);
    for(int i = 0; i < 7; i++) {
        flag[i] = false;
        order[i] = order[i + 7];
    }
    for(int i = 7; i < 14; i++) {
        while(flag[result]) result = (int)random(7);
        order[i] = result;
        flag[result] = true;
    }
}

void imageBlock() {
    Block a;
    switch(block.getClass().getTypeName()) {
        case "Tetris$BlockT":
            a = new BlockT().setColor(color(200, 0, 200));
            break;
        
        case "Tetris$BlockS":
            a = new BlockS().setColor(color(0, 200, 0));
            break;

        case "Tetris$BlockZ":
            a = new BlockZ().setColor(color(200, 0, 0));
            break;

        case "Tetris$BlockJ":
            a = new BlockJ().setColor(color(0, 0, 200));
            break;

        case "Tetris$BlockL":
            a = new BlockL().setColor(color(200, 130, 0));
            break;
        
        case "Tetris$BlockI":
            a = new BlockI().setColor(color(0, 150, 200));
            break;
        
        case "Tetris$BlockO":
            a = new BlockO().setColor(color(200, 200, 0));
            break;
        
        default:
            a = new Block();
    }
    switch(block.rotateState) {
        case 3:
            a.rotateLeft();
        
        case 2:
            a.rotateLeft();
        
        case 1:
            a.rotateLeft();
        
        case 0:
            break;
    }
    while(a.getR1().getPos().y < block.getR1().getPos().y) a.move2();
    a.moveX((int)(block.getR1().getPos().x - a.getR1().getPos().x)).moveToBottom2().show();
}

void keyPressed() {
    if(state == 0) {
        if(key == ' ') {
            replayTime = millis();
            init();
            update();
            state++;
        }
    }
    else if(state == 1) {
        if(key == CODED) {
            if(keyCode == RIGHT) block.moveRight();
            if(keyCode == LEFT) block.moveLeft();
            if(keyCode == UP) block.rotateRight();
        }
        if(key == 'z') block.rotateLeft();
        if(key == ' ') block.moveToBottom();
        if(key == 'c' && canHold) {
            if(hold == null) {
                hold = block;
                count++;
                if(count == 7) {
                    count = 0;
                    makeOrder();
                }
                update();
            }
            else {
                Block tmp = block;
                block = hold;
                hold = tmp;
            }
            canHold = false;
        }
    }
    else if(state == 2) {
        if(key == ENTER) {
            blocks = new Vector();
            block = null;
            hold = null;
            level = 1;
            count = 0;
            canHold = true;
            score = 0;
            tetrisCount = 0;
            tSpinCount = 0;
            lines = 0;
            keyPressedTime = 0;
            v = 1000;
            state = 0;
        }
        if(key == ESC) exit();
    }
}