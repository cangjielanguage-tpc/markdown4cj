export function drawCircleImage(
  str: string,
  fontSize: number,
  fontColor: number,
  fontBackgroundColor: number,
  backgroundColor: number,
  textHeight: number,
  colorFormat: number
): ArrayBuffer | undefined;

export function drawRectImage(
  str: string,
  fontSize: number,
  fontColor: number,
  fontBackgroundColor: number,
  backgroundColor: number,
  textHeight: number,
  colorFormat: number,
  padding: number,
  radius: number,
  isFakeBoldText: boolean
): ArrayBuffer | undefined;

export function drawRectToolImage(
  str1: string,
  str2: string,
  fontSize: number,
  fontColor: number,
  fontBackgroundColor: number,
  backgroundColor: number,
  borderColor: number,
  borderWidth: number,
  dividingLineColor: number,
  dividingLineWidth: number,
  textHeight: number,
  colorFormat: number,
  padding: number,
  lineLeftPadding: number,
  lineRightPadding: number
): ArrayBuffer | undefined;
