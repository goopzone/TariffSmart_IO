import { AlertTriangle } from "lucide-react";

export function WarningBanner() {
  return (
    <div className="bg-red-600 border-b-2 border-red-700">
      <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-3">
        <div className="flex items-center justify-center gap-3 text-white">
          <AlertTriangle className="h-5 w-5 flex-shrink-0" />
          <p className="text-sm sm:text-base font-medium text-center">
            <strong>Warning:</strong> This is an experimental website and is no longer being updated. 
            Do not use this website as a source of information for making decisions.
          </p>
          <AlertTriangle className="h-5 w-5 flex-shrink-0" />
        </div>
      </div>
    </div>
  );
}
