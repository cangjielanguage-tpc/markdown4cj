package markdown.components.theme

/**
 * 装饰线样式枚举
 */
public enum MarkdownTextDecorationStyle <: Equatable<MarkdownTextDecorationStyle> {
    | SOLID // 单实线
    | DOUBLE // 双实线
    | DOTTED // 点线
    | DASHED // 虚线
    | WAVY // 波浪线

    public operator func ==(that: MarkdownTextDecorationStyle): Bool {
        match ((this, that)) {
            case (SOLID, SOLID) => true
            case (DOUBLE, DOUBLE) => true
            case (DOTTED, DOTTED) => true
            case (DASHED, DASHED) => true
            case (WAVY, WAVY) => true
            case _ => false
        }
    }

    public operator func !=(that: MarkdownTextDecorationStyle): Bool {
        return !(this == that)
    }

    public static func fromInt64(int: Int64): ?MarkdownTextDecorationStyle {
        return match (int) {
            case 0 => SOLID
            case 1 => DOUBLE
            case 2 => DOTTED
            case 3 => DASHED
            case 4 => WAVY
            case _ => None
        }
    }

    public func toInt64(): Int64 {
        return match (this) {
            case SOLID => 0
            case DOUBLE => 1
            case DOTTED => 2
            case DASHED => 3
            case WAVY => 4
        }
    }

    public func toInt32(): Int32 {
        return Int32(toInt64())
    }
}
