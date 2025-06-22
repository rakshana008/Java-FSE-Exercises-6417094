class Computer {
    private String CPU, RAM, storage;

    private Computer(Builder builder) {
        this.CPU = builder.CPU;
        this.RAM = builder.RAM;
        this.storage = builder.storage;
    }

    public static class Builder {
        private String CPU, RAM, storage;

        public Builder setCPU(String c) { this.CPU = c; return this; }
        public Builder setRAM(String r) { this.RAM = r; return this; }
        public Builder setStorage(String s) { this.storage = s; return this; }

        public Computer build() {
            return new Computer(this);
        }
    }

    public String toString() {
        return "Computer[CPU=" + CPU + ", RAM=" + RAM + ", Storage=" + storage + "]";
    }
}

public class BuilderPatternExample {
    public static void main(String[] args) {
        Computer comp = new Computer.Builder()
            .setCPU("Intel i5")
            .setRAM("16GB")
            .setStorage("512GB SSD")
            .build();
        System.out.println(comp);
    }
}
