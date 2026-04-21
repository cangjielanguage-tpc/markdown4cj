package markdown.components.theme

/**
 * 数学公式生成图片格式枚举
 */
public enum LatexMathColorFormat <: Equatable<LatexMathColorFormat> {
    | COLOR_FORMAT_RGB_565 // 16位
    | COLOR_FORMAT_BGRA_8888 // 32位

    public operator func ==(that: LatexMathColorFormat): Bool {
        match ((this, that)) {
            case (COLOR_FORMAT_RGB_565, COLOR_FORMAT_RGB_565) => true
            case (COLOR_FORMAT_BGRA_8888, COLOR_FORMAT_BGRA_8888) => true
            case _ => false
        }
    }

    public operator func !=(that: LatexMathColorFormat): Bool {
        return !(this == that)
    }

    public static func fromInt64(value: Int64): ?LatexMathColorFormat {
        match (value) {
            case 0 => COLOR_FORMAT_RGB_565
            case 1 => COLOR_FORMAT_BGRA_8888
            case _ => None
        }
    }

    public func toInt64(): Int64 {
        match (this) {
            case COLOR_FORMAT_RGB_565 => 0
            case COLOR_FORMAT_BGRA_8888 => 1
        }
    }
}
