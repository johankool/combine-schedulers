#if compiler(>=5.4)
  #if canImport(OpenCombineShim)
    import OpenCombineShim
    import CombineSchedulers
    import XCTest

    final class UnimplementedSchedulerTests: XCTestCase {
      
      #if !os(Android)
      func testFailure() {
        let scheduler = RunLoop.unimplemented

        XCTExpectFailure { _ = scheduler.now }
        XCTExpectFailure { _ = scheduler.minimumTolerance }
        XCTExpectFailure {
          let expectation = self.expectation(description: "schedule")
          scheduler.schedule(options: nil) {
            expectation.fulfill()
          }
          self.wait(for: [expectation], timeout: 0.1)
        }
        XCTExpectFailure {
          let expectation = self.expectation(description: "schedule")
          scheduler.schedule(after: .init(.init()), tolerance: .zero, options: nil) {
            expectation.fulfill()
          }
          self.wait(for: [expectation], timeout: 0.1)
        }
        XCTExpectFailure {
          let expectation = self.expectation(description: "schedule")
          _ = scheduler.schedule(after: .init(.init()), interval: 1, tolerance: .zero, options: nil)
          {
            expectation.fulfill()
          }
          self.wait(for: [expectation], timeout: 0.1)
        }
      }
      #endif
    }
  #endif  // canImport(OpenCombineShim)
#endif
