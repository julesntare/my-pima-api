import path from "path";
import { fileURLToPath } from "url";

const getDirName = function (moduleUrl) {
  const filename = fileURLToPath(moduleUrl);
  return path.dirname(filename);
};

export { getDirName };
